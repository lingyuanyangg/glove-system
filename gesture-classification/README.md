# Glove Gesture — FluCoMa Classification for Max for Live

A compact gesture classifier for the **ElastremeSense Manu-5D e-skin data glove kit** project. Select **Left**, **Right** or **Both**, record your own examples, train a native FluCoMa classifier, and use stable gesture entry to operate mapped Live device buttons.

The six illustrated gestures are **Open hand, Fist, Index extended, V sign, Middle extended and OK**. Original SVG line drawings are embedded in the UI; Left mirrors the hand, Right shows the opposite orientation, and Both shows a pair. In Both mode the drawings are references: you may train a different pose on each hand as one combined gesture.

![Original gesture illustrations](validation/gesture-art.png)

[Download the device package](Glove%20Gesture.zip). Keep every file in the extracted **Glove Gesture** folder together. This is an audio effect with direct stereo pass-through; place it on an audio track or after an instrument.

## Requirements and installation

- Ableton Live with Max for Live. Files were generated with Max 9.1.5 metadata; this is not a verified minimum host version.
- **FluCoMa / FluidCorpusManipulation 1.0.9** is installed on the development machine and is the version checked for native message/JSON behavior. Install it through Max Package Manager. Later versions require their own host acceptance checks.
- A running glove receiver publishing five normalized floats to **`GLeft`** and/or **`GRight`**. The project's Dual receiver uses UDP 7000 for Left and 6000 for Right. This device consumes the Max buses and does not bind another UDP socket.
- The receiver's channel order is **pinky, ring, middle, index, thumb**. Both concatenates Left followed by Right. Train and run with the same receiver calibration/filter settings; changes require retraining.

Drag `Glove Gesture.amxd` into Live and open `?` for the built-in guide. The UI should report **FLUCOMA READY**. Missing native objects or replies disable training and Run and give a diagnostic. Reload the device after installing a missing package or updating its companion files.

## Record and train

1. Choose Left, Right or Both. Each hand mode has an independent example/model bank. Both needs current data from both hands, with arrival times within 80 ms; a frame expires after 300 ms.
2. Hold a gesture and click its **+ Rec** button. The two-second recording captures fresh incoming frames at most once every 50 ms. Repeat 5–10 times with small natural variations, rather than duplicating a single recorded pose. Counts are shown on each card. There is a 400-example limit per class.
3. Record **Other** several times with relaxed poses and the transitions between gestures. Other is required and never maps to an action. Disable gesture checkboxes for classes you do not want to train. At least **20 examples per enabled gesture and Other** are required; this is a basic guard, not a guarantee of sufficient training data.
4. Press **Train**. A native `fluid.dataset~` and `fluid.labelset~` share example identifiers and feed `fluid.mlpclassifier~`. Left/Right use 5→8→classes; Both uses 10→16→classes. Hidden activation is tanh; FluCoMa's classifier uses sigmoid outputs and chooses a label. Defaults are 500 epochs, learning rate 0.01, momentum 0.9, batch size 4, validation 0. Fitting is divided into short native chunks, and the best completed training-loss checkpoint is retained.
5. Press **Run**, initially without mappings, and test new repetitions. A confirmed gesture lights its card. Evaluate the difficult pairs, especially Index/V/Middle and OK. Add diverse examples where they are confused. **Training RMSE is not held-out classification accuracy.** For independent evaluation, reserve whole repetitions or recording sessions instead of randomly splitting adjacent frames.

The device has no pretrained hand model. The pictures indicate the intended poses; your own recordings define what those labels mean for the glove. OK is learned from finger bend values. Thumb/index contact, palm orientation, hand position and unmeasured movements cannot be inferred reliably when their measured finger patterns are indistinguishable.

## Native button mappings

Each gesture has an embedded **native Max for Live Map component** below its card. Turn Run off, click **Map**, then click a Live **two-state DeviceParameter button**, such as Device On/Off or an effect switch. Use × to unmap. A plug-in switch exposed as a non-quantized 0–1 parameter is also accepted. Continuous controls with other ranges and multi-state enums are rejected.

| Action | On confirmed gesture entry | On exit / Stop |
| --- | --- | --- |
| Toggle | Invert the parameter's current state once | Retain the resulting state |
| Pulse | Write the high state | Write low after the Pulse interval; Stop releases earlier |
| Hold | Write the high state | Write low when the confirmed gesture exits, Run stops or input is lost |
| On | Write the high state once | Retain the high state |
| Off | Write the low state once | Retain the low state |

Actions write through the Live Object Model, without reserving a `live.remote~` channel. Each action checks that the mapped parameter still exists, has the expected button range, and is writable. Changing mappings stops Run. Native mapping IDs are persisted by the embedded component, rather than copied into the model JSON.

Pulse and Hold return the target to **low**, not its previous value. A release only writes if the target remains at the high value the device set; a manual change away from high is respected. When several gestures map to one target, a later action supersedes its earlier pending temporary release. Transport, clip launch, track arm/mute/solo and arbitrary UI buttons are not DeviceParameter mappings here; those require dedicated Live API or MIDI integrations.

## Trigger filtering and unknown poses

- **Hold**, default **120 ms**: the candidate label must remain stable for this period before it becomes the confirmed gesture. Short recognition fluctuations do not trigger another action. This also delays Hold releases during ordinary transitions.
- **Gap**, default **350 ms**: minimum time between gesture-entry triggers. Keeping the same gesture does not repeatedly fire. Return to a confirmed Other or another gesture before re-entering it.
- **Pulse**, default **120 ms**: duration of Pulse actions, checked by a 25 ms housekeeping task.
- **Radius**, default **0.18**: maximum RMS distance across normalized finger values from the predicted class to its nearest recorded example. A more distant pose is treated as Other. Radius is a feature-space threshold, **not a confidence probability**; it does not guarantee recognition of all unknown poses.
- Invalid frames stop Run. Missing/stale input releases temporary states and clears recognition; Run can resume recognition when valid input returns. Stop, hand changes, model changes and settings changes invalidate pending predictions. Native frame requests coalesce to the latest pending frame, with at most one outstanding inference request.

Prediction is triggered by fresh glove frames, rate-limited to at most 50 requests/second. Housekeeping and UI updates do not substitute stale frames for new glove measurements.

## Models and Live Set recall

Enter a name and **Save** a trained snapshot. The selector lists saved models and their hand modes. **Load** requires a matching mode and restores that model's enabled classes, examples, weights and training loss, with Run off. Left and Right models are separate even though both have five inputs. Saved snapshots are independent copies.

Save the Live Set to retain all three banks, up to 64 named snapshots, action types and timing/distance settings. Native Map components retain their own mappings with the Set. Run/recording/training state and held outputs are not restored as active states.

**Export / Import** transfers a `glove-gesture-model` version-one JSON file containing the native `{mlp, labels}` classifier, hand mode, examples with trial identifiers and enabled classes. Imported files receive a new library identity. Models include examples because the rejection gate uses them. They do not include Live button IDs or mappings. Regression/Data Knot model files have a different format and cannot be used as classification models.

## Max event buses

| Receiver | Messages |
| --- | --- |
| `r GGestureLeft` | `enter <label> <number>` / `exit <label> <number>` in Left mode |
| `r GGestureRight` | The same messages in Right mode |
| `r GGestureBoth` | The same messages for the combined pose in Both mode |

Labels/numbers are `open` 1, `fist` 2, `index` 3, `v` 4, `middle` 5 and `ok` 6. Other is quiet. Stop/input-loss emits exit for an active gesture. These buses are shared throughout Max, as are the incoming glove buses; running several classifiers publishes several streams on the same names.

## Implementation and validation

The generated `.maxpat` is the readable patch source; the AMXD payload contains the same patch. All neural optimization and inference run in native FluCoMa. ES5 Max JS manages examples, native acknowledgements, temporal filtering, distance rejection, Live actions, models and UI state. The instance `#0` isolates all native datasets, buffers, models and dictionary peers.

Six original SVG assets are under `assets/` and embedded into the HTML during build. The native mapping UI is embedded from the installed `liveui.map.maxpat`; it retains native persistence and theme behavior, with presentation sizes and parameter names adjusted. The hand-art contact sheet is a raster rendering of those SVG files, **not a Live screenshot**.

See [VALIDATION.md](VALIDATION.md) for completed checks and the Max/Live/hardware boundary. Standalone checks do not establish real-glove accuracy, audio behavior, mapping recall or end-to-end latency in Live.

Official references: [FluCoMa MLPClassifier](https://learn.flucoma.org/reference/mlpclassifier/), [MLP training](https://learn.flucoma.org/learn/mlp-training/), [DeviceParameter](https://docs.cycling74.com/apiref/lom/deviceparameter/).
