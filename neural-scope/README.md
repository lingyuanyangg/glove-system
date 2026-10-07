# Glove Neural Scope

A Max for Live audio effect that learns glove gestures → parameters of a target device. It combines the neural regression workflow of the supplied `reressorMapping2` with Scope Lab's track/device discovery, parameter table, output bounds and fixed native remote-control pool. The glove hardware platform is the **ElastremeSense Manu-5D e-skin data glove kit**.

## Install and operate

Keep `Glove Neural Scope.amxd`, `neural_scope_control.js` and `neural_scope_ui.html` together. Load the audio effect on an audio track, or after an instrument on a MIDI track. Stereo audio passes through.

Use the **Glove Receiver Dual** as the source: this device reads the normalized Max buses `GLeft` and `GRight` and does not bind another UDP receiver. Left/Right uses five values; Both concatenates Left then Right into ten values. Each hand is ordered **pinky, ring, middle, index, thumb**. Both requires valid data from both hands; no zero-padding is used. After loading, move the fingers once to obtain a first frame. Stable and disconnected sources both retain their last valid frame because these buses have no connection heartbeat.

1. Choose **This track** or **Selected track**. The former means the utility's own track; the latter follows Live's selected track. **Follow** tracks the chosen track's selected device; manually choosing TARGET pins a device. Rack chain devices are included, and the utility excludes itself.
2. Choose **Left / Right / Both**, and scope the parameters to learn. Device On is excluded by default. Use the larger **↗** editor for the full parameter table. Up to 256 parameters can be controlled together.
3. With **Run off**, make a pose, set the target sound, and click **Capture**. Capture 8–20 distinct poses as a starting point; two are the minimum and 512 the bank limit. Near-identical poses are rejected.
4. Click **Train**, then **Run**. Epochs defaults to 800, adjustable from 50 to 5000. Training yields between small scheduled chunks and can be cancelled. RMSE reports training error, not generalization accuracy.
5. **Stop** releases all native remote mappings. Changing target, track, input mode or scope stops control rather than transferring active control automatically.

## Neural processing and compatibility

New training uses an embedded ES5 multilayer perceptron: **5 or 10 → 16 tanh units → N linear outputs**, where N is the scoped parameter count. Adam updates the weights with MSE gradients. The best measured training checkpoint is retained. Each predicted value is clipped to 0–1, converted to the parameter's complete native range, then clamped to its custom Min/Max bounds. Quantized parameters round to valid integer steps.

## Saved model selector

After training, enter **Model name** and press **Save**. This creates an independent, immutable named snapshot in the device's **MODEL** selector; names may repeat and snapshots have distinct IDs. Choose a saved model and press **Load** to restore its scoped outputs, custom Min/Max, examples and neural weights. Loading stops Run and releases current mappings first. Matching hand mode and target parameter structure are required; changing current Scope does not prevent loading because the snapshot restores its own scope. Models do not store runtime Live IDs.

Snapshots live in the **Live Set**: save the Set to retain them. Use **Export** to save the selected snapshot to a JSON file; use **Import** to bring previously exported models into another Set. A compatible import is loaded with Run off; an incompatible import stays in the selector until the matching hand mode and target are chosen. Native [opendialog](https://docs.cycling74.com/reference/opendialog/) and [savedialog](https://docs.cycling74.com/reference/savedialog/) choose files; the [Max File API](https://docs.cycling74.com/apiref/js/file/) reads/writes JSON. Cancelled dialogs leave snapshots intact. Use **×** to remove the selected named snapshot; this does not erase the active training bank. Up to 128 named snapshots can be stored per device.

No preset model is bundled or loaded automatically. The old default JSON has been removed. Import additionally accepts a **user-selected Data Knot regression JSON** with a five-input/ten-output model, using Left or Right and exactly ten scoped outputs. Those files contain no Live parameter identities, so outputs bind in the current scoped table order. Both needs a ten-input model. New training uses the embedded engine and needs no Data Knot/FluCoMa package installation.

Each target, input mode and scoped parameter structure has an independent sample/model bank. Switching scope does not erase previous banks. Adding/removing examples invalidates the current trained model. Custom Min/Max are output clamps in Live's internal units, not a rescaling of the learned sound. Hover Live value for the host's formatted units.

## Host control and state

The receiver's input jitter filter remains upstream. Native `live.remote~` adds default **30 ms** output smoothing, adjustable from 0–500 ms. Mapping temporarily takes over direct parameter editing and automation, without adding undo steps for each streamed change; Stop releases the mapping and the underlying Live base values become active again. These semantics follow the [official remote-control reference](https://docs.cycling74.com/reference/live.remote~/).

Device discovery and parameter access use cached Live API objects, initialized after `live.thisdevice`, with deferred inlet messages. The selected device comes from [Track.View.selected_device](https://docs.cycling74.com/apiref/lom/track_view/); ranges, quantization and availability follow [DeviceParameter](https://docs.cycling74.com/apiref/lom/deviceparameter/).

Samples, weights, named model snapshots, scope, bounds and settings are stored in a non-automatable Blob with the Live Set. Save the Set to retain them. Run is always off after restore. Live parameter IDs are rebuilt from device position and parameter structure; substantial reordering/replacement needs review before Run. Input frames are not saved. A pinned target is chosen again using TARGET after reload.

The 1060 × 169 compact interface uses flat gray controls and orange state indicators, with a larger editor. Native [live.colors](https://docs.cycling74.com/reference/live.colors/) messages update its theme palette. The interface is local `jweb`, with no online UI resources or services.

## Validation and source

Offline neural, adapter, packet/theme/model-selector and AMXD structural checks pass. This release has **not been validated in the native Live host or with physical gloves**. Local browser preview was denied and Live UI access was unavailable. See [VALIDATION.md](VALIDATION.md) for exact checks and acceptance steps.

```sh
python3 tools/build.py
node tools/test_neural.js
node tools/test_adapter.js
node tools/test_ui.js
python3 tools/test_patch.py
```

`tools/neural_core.js` and `tools/live_adapter.js` compose the shipped controller. The only runtime companions are the controller JS and local HTML; no default model JSON is required. `Glove Neural Scope.maxpat` is editable source; its parsed patcher equals the AMXD payload. The package targets Max 9 and a Live edition with Max for Live. Scope Lab and the original devices remain unchanged.
