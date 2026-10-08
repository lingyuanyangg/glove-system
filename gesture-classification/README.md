# Glove Gesture — Single-Pose UI and Combined-Hand Classification

A Max for Live gesture classifier for the **ElastremeSense Manu-5D e-skin data glove kit** system, using native FluCoMa. The compact **800 × 169** main interface displays one selected pose at a time. During Run it displays the detected pose, with **Confirming / Confirmed / Other** status. The **Mapping** button opens a separate window for button assignments and action types.

[Download the device](Glove%20Gesture.zip). Keep all seven runtime files together. Load `Glove Gesture.amxd` on an audio track or after an instrument; stereo audio passes through. Install **FluidCorpusManipulation 1.0.9**, the version checked locally, through Max Package Manager. Run the project's Dual receiver first: Left is UDP 7000, Right is UDP 6000; this classifier listens to `GLeft`/`GRight` rather than binding another socket.

## Train a single hand

1. Choose **Left hand** or **Right hand**.
2. Choose **Open hand, Fist, Index, V sign, Middle or OK** from the training dropdown. The selected hand drawing appears in the main pose area, mirrored appropriately.
3. Click **Record 2s** while performing that pose. The class is enabled automatically; repeat 5–10 times with natural variations. **Include in training** can exclude the selected class, and Clear deletes only its examples.
4. Use **Other 2s** to record relaxed poses and transitions. Train requires at least 20 examples of every enabled class and Other. Unrecorded classes start disabled, so a small selected vocabulary can be trained first.
5. Press **Train**, then **Run**. The main image now follows the detected gesture. Confirming means the stable-time guard has not yet accepted it; Confirmed indicates the active trigger. Other displays an unknown marker. The training dropdown is locked while running or recording.

## Train two different hand poses together

Choose **Both hands**. Select the left pose and right pose independently, for example **Left Fist + Right V sign**. Both drawings appear in one combined pose area. Record 2s captures synchronized **Left five values followed by Right five values**, with one combined label `fist__v`. Change either dropdown to record another combination, then record Other and Train.

There are **36 ordered combinations** (six choices per hand); `fist__v` and `v__fist` are different classes. Only enabled recorded pairs participate in training. This is one ten-dimensional classifier that recognizes a complete paired pose, not two classifiers whose labels are merged after prediction. During Run, both displayed hand drawings change to the detected combination.

Glove channel order is **pinky, ring, middle, index, thumb**. Keep calibration and receiver filtering consistent between training and performance. Both requires frame arrival times within 80 ms, and each frame expires after 300 ms. If either hand is missing, temporary outputs release and recognition clears. Invalid frames stop Run.

The six original SVG drawings are pose references. There is no pretrained hand model. The OK drawing shows thumb/index contact, but the available inputs measure finger bend; identical measured patterns cannot distinguish contact, orientation or hand position.

![Original pose illustrations](validation/gesture-art.png)

## Separate Mapping window

Click **Mapping**. Its hand-mode selector changes which assignments are displayed without changing the classifier's active mode. Left has six independent slots, Right has another six, and Both has one slot for each of the 36 ordered pairs: **48 mappings total**. Both initially shows recorded/enabled/mapped combinations; enable **Show all combinations** to display every pair.

Click a row's **Map**, then click a two-state DeviceParameter button in Live, such as Device On/Off or an effect switch. Mapping stops Run. **×** clears the assignment. A plug-in switch exposed as a non-quantized 0–1 parameter is accepted; other continuous ranges and multi-state enums are rejected. Native `live.map @strict 1` handles selection, while one persistent `live.object` per slot stores the authoritative Live identity and returns it on recall. Both windows receive state directly from their own device instance.

| Action | Result |
| --- | --- |
| Toggle | Invert the target once on stable gesture entry |
| Pulse | Write high, then low after the Pulse interval |
| Hold | High while that confirmed gesture is active; low on exit, Stop or input loss |
| On / Off | Write the requested state once and retain it after exit |

Pulse/Hold release to the low value, not the previous state. If a target was manually changed away from high, release respects that change. A later action on a shared target supersedes its previous temporary release. Transport, clip launch, track arm/mute/solo and arbitrary UI buttons require separate Live API/MIDI integrations; this window maps device parameters.

## Timing, training and models

Defaults: **Hold 120 ms**, **Gap 350 ms**, **Pulse 120 ms**, **Radius 0.18**, **500 epochs**. A stable held pose fires once; return to Other or another confirmed pose before re-entering. Radius is the RMS normalized finger distance to the predicted class's nearest recorded example. A larger distance becomes Other; this is not a confidence probability or a guarantee that every unknown gesture is rejected.

Native networks use **5→8→classes** for single hands and **10→32→classes** for combined hands, tanh hidden activation and FluCoMa's sigmoid classifier outputs. Learning rate 0.01, momentum 0.9, batch size 4, validation 0. Native fit is chunked, retaining the best completed training-loss checkpoint. At most 400 examples per class and 8,000 total examples in a Both bank are accepted. Training error is not independent accuracy. Test new whole repetitions/sessions, especially Index/V/Middle/OK and pair transitions.

Save named snapshots in the model selector; Load requires the matching input mode and restores classes, examples and weights with Run off. The Live Set retains three banks, training selections, up to 64 models, 48 action types and timing settings. Native mapping holders retain their own identities. Export/Import transfers version-two `glove-gesture-model` JSON, including examples needed for rejection, without Live button assignments.

**Upgrade:** reload the updated AMXD with its companions. A copy of the earlier installed device folder is retained locally when updating. Version-one single-hand models remain compatible. Old Both files have only one gesture name, so migration assigns it to the same pose on both hands (`open` → `open__open`) while retaining input samples, native weights and label order. If an old class actually represented different left/right poses, re-record with the correct dropdown labels; those meanings cannot be recovered from its old metadata. Review/remap button assignments after replacing the device, since the mapping component structure has changed.

## Max outputs

`r GGestureLeft`, `r GGestureRight`, `r GGestureBoth` receive `enter <label> <number>` / `exit <label> <number>`. Single-hand numbers are Open 1, Fist 2, Index 3, V 4, Middle 5, OK 6. For Both, labels are `left__right` and numbers are **1 + leftIndex × 6 + rightIndex**, with zero-based indices in that order; Fist + V is `fist__v` 10. Other is quiet. Stop/loss sends exit for an active class. These buses are shared throughout Max; native state and mapping-window communication are per instance.

[VALIDATION.md](VALIDATION.md) records completed offline/native checks and remaining Max/Live/real-glove acceptance. SVG artwork was rasterized and inspected; its contact sheet is not a Live screenshot. The source builder embeds both HTML UIs and uses built-in native mapping objects; no external mapping abstraction is required.

Official references: [FluCoMa MLPClassifier](https://learn.flucoma.org/reference/mlpclassifier/), [live.map](https://docs.cycling74.com/reference/live.map), [persistent live.object](https://docs.cycling74.com/reference/live.object).
