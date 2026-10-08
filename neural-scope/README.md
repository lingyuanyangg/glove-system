# Glove Neural Scope

A FluCoMa-based Max for Live audio effect that learns **Left**, **Right** or **Both** hand poses to parameters of a chosen Live device. The compact **1060 × 169** interface has target discovery, parameter Scope, output bounds and a saved-model selector; ↗ opens a larger editor. Stereo audio passes through.

[Download Neural Scope](Glove%20Neural%20Scope.zip) · [中文操作说明](README_中文.md)

## Install

Install **FluidCorpusManipulation / FluCoMa** in Max Package Manager. Keep `Glove Neural Scope.amxd`, `neural_scope_control.js` and `neural_scope_ui.html` together in `Glove_Neural_Scope`. Load on an audio track or after an instrument.

Connect and calibrate [Glove Receiver Dual](../receiver-v2/README.md) in the same Set. This device reads `GLeft` / `GRight`. One hand has five inputs; Both concatenates Left then Right for ten, with **pinky, ring, middle, index, thumb** order within each hand. Both requires an initial valid frame from each hand and keeps the latest values; it has no per-hand timeout/pair-skew guard. Stop before disconnecting a source.

## Capture, train and run

1. Select **This track** for the effect's own track or **Selected track** for Live's selected track. **Follow** uses the chosen track's selected device; choosing **TARGET** pins a device. Rack-chain devices are included.
2. Choose Left/Right/Both and enable the parameters to learn in **Scope**. Device On starts excluded. Use ↗ for the full table; up to 256 outputs can be selected. Use a plug-in's Configure feature if a parameter is not exposed to Live.
3. Keep **Run off**. Make a pose, adjust the target sound, then click **Capture**. Start with 8–20 distinct pose/sound pairs. At least two are required; the bank limit is 512. Near-identical poses are rejected.
4. Click **Train**, then **Run**. Epochs defaults to 800. Training can be cancelled. RMSE is training error, not performance on unseen gestures.
5. **Stop** releases all mapped parameters. Changing target, track, input mode or Scope also stops control; enable Run explicitly for the selected configuration.

Capture/editing is unavailable during Run. Every target, input mode and scoped-output structure has an independent bank. Adding/removing examples invalidates the active trained model. Keep Receiver calibration/filter settings consistent with captured examples.

## Output bounds

**Min / Max** clamp learned outputs in each parameter's native units; they do not rescale the model. Quantized parameters snap to their supported steps. Native output smoothing defaults to **30 ms**, adjustable 0–500 ms. During Run, remote mappings take control from direct editing/automation. Stop releases that control and Live's underlying parameter values become active.

## Model selector

After training, enter **Model name** and click **Save**. The MODEL selector holds independent named snapshots. Select one and **Load** to restore its examples, neural weights, scoped outputs and bounds with Run off. Input mode and target parameter structure must match. Up to 128 named models are stored per device.

Save the Live Set to retain banks, snapshots and settings. **Export** writes a selected snapshot to JSON; **Import** adds a compatible JSON to the selector. **×** removes a named snapshot without clearing the working bank. No model is loaded automatically.

Raw FluCoMa MLP JSON can be imported when input/output dimensions match the selected hand mode and scoped outputs. A user-selected Data Knot five-input/ten-output regression JSON requires Left or Right and exactly ten scoped outputs. Raw models bind to current scoped table order. Data Knot is not required for training or running this device.

Review target selection after changing the track/device arrangement. Run always recalls off; pinned TARGET selection must be chosen again after reload.

## Processing

Native `fluid.mlpregressor~` performs training and inference. Networks use **5 or 10 → 16 tanh units → N linear outputs**, SGD with momentum, and scheduled fit chunks. Glove frames trigger prediction; bursts coalesce while one native request is in flight. Output is clipped to 0–1, converted to native parameter ranges, clamped and quantized as appropriate. The UI is local HTML and uses Live theme colors.

See the [technical specification](../docs/TECHNICAL.md) for learning parameters and model behavior, and [operating guide](../docs/OPERATING.md) for setup/troubleshooting.
