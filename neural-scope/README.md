# Glove Neural Scope

A FluCoMa Max for Live audio effect that learns Left, Right or Both hand poses to a **combined set of parameters from multiple Live devices**. Targets can be on the same track, inside Rack chains or on different tracks. One Capture records all included outputs, and one trained model controls them together. The Live-themed interface remains **1060 × 169**; ↗ opens the larger editor. Stereo audio passes through.

[Download Neural Scope](Glove%20Neural%20Scope.zip) · [中文操作说明](README_中文.md)

## Install

Install **FluidCorpusManipulation / FluCoMa** through Max Package Manager. Keep `Glove Neural Scope.amxd`, `neural_scope_control.js` and `neural_scope_ui.html` together in `Glove_Neural_Scope`. Load on an audio track or after an instrument. Reload an existing instance to use the installed controller and interface.

Connect and calibrate [Glove Receiver Dual](../receiver-v2/README.md) in the same Set. Neural Scope reads `GLeft` / `GRight`. One hand has five inputs; Both concatenates Left then Right for ten. Within each hand the order is pinky, ring, middle, index, thumb. During Run and immediate capture, the device keeps each hand's latest valid frame without a per-hand timeout or pair-skew guard; delayed capture checks freshness as described below. Stop before disconnecting a source.

## Build the target set

1. **This track** browses the effect's track; **Selected track** browses Live's selected track. **Follow** follows that track's selected device for browsing. Choosing the device menu disables Follow. Browsing does not replace already included targets.
2. The first selected device is included automatically. Browse another device, click **Add**, then enable the required **Scope** rows. New additional devices start with Scope off. Device On is excluded initially.
3. Repeat for the other devices. Use Selected track to browse a different track before Add. Added devices remain pinned when the selected track changes. Rack-chain devices are listed too.
4. **Targets** opens the included-device list with View, Remove and per-device output counts. **Remove** excludes the browsed target. All / None / First 10 apply only to the browsed device. Output numbers run across the combined set in target-add order, then parameter-table order.

The limits are **32 target devices and 256 scoped outputs in total**. The limit is shared across devices. A plugin's Configure feature exposes parameters to Live when needed. Removing a target retains its settings and previous training banks.

## Capture, train and run

1. Choose Left / Right / Both and configure every target's Scope. Keep Run off.
2. Make a glove pose, adjust sounds on **all included devices**, then click **Capture** once. The example contains one glove vector and all combined parameter values. Start with 8–20 distinct pose/sound pairs; at least two are required and a bank holds up to 512. Near-identical poses are rejected.
3. Click **Train**, then **Run**. Native `fluid.mlpregressor~` learns one joint output vector. Epochs defaults to 800; RMSE measures training error. Check new poses and transitions, add examples and retrain as needed.
4. **Stop** releases every mapped parameter on every target. Target membership, input-mode or Scope changes stop control. Browsing another device or track retains the pinned set and can continue while Run is on.


**Delay s** defaults to 5 (0–15). Set the sounds, click Capture, then prepare the glove pose during the countdown; exactly one example is taken at the deadline. Capture reads all scoped target values at that time. Use 0 for immediate capture. Stop cancels; target membership, input mode, Scope or output-bound changes also cancel. You may adjust sound values while waiting. Delayed capture requires fresh hand frames (within 300 ms, Both arrival skew within 80 ms); missing input cancels rather than storing held values. Repeat Capture for each distinct pose/sound pair. Train uses recorded examples, so neither hand needs to stay in position during fitting. Delay is saved with the Set; pending captures recall off.

Each ordered target set, input mode and combined Scope has an independent bank. Returning to the same configuration recalls that bank. Adding/removing examples invalidates its trained model. A larger combined output set needs new training examples; an existing single-device model does not acquire additional learned outputs automatically.

## Output bounds and control

Min / Max clamp predictions in each parameter's native units; they do not rescale the learned output. Quantized parameters snap to valid integer steps. Native `live.remote~` smoothing defaults to 30 ms, adjustable 0–500 ms. Run takes control from manual editing and automation; Stop releases it and Live's underlying values become active. Capture and parameter editing are disabled during Run.

If any target is deleted, moved or changes its parameter list, control of the entire set stops. Review Scope before running again. Missing restored targets remain explicit entries; they are not silently dropped from the model. Remove and re-add a changed target if necessary.

## Saved models and Set recall

After training, enter a model name and **Save**. Select a snapshot in MODEL and **Load** to restore its target list, examples, neural weights, Scope and bounds with Run off. Input hand mode must match. Multi-device snapshots store ordered structural device paths and parameter structures; Load validates every target before changing the active set. Up to 128 named models are retained.

Save the Live Set to retain target membership, banks, snapshots and settings. Runtime Live IDs are not serialized as target identities. Review saved paths after replacing or rearranging devices, especially identical devices. Run always recalls off. **Export / Import** transfers named models as JSON; × removes a snapshot without clearing the active bank.

Earlier single-device Set data and model JSON remain supported. Legacy named models require one compatible target because they contain no multi-device target list. Raw FluCoMa MLP JSON binds outputs to the **current combined Scope order** when dimensions match. Data Knot five-input/ten-output regression JSON requires Left or Right and exactly ten combined scoped outputs. No model is loaded automatically.

## Processing

Native FluCoMa performs training and inference: **5 or 10 → 16 tanh units → N linear outputs**, SGD with momentum and scheduled fit chunks. Glove frames request prediction; bursts coalesce while one native request is in flight. Outputs are clipped to 0–1, converted to native ranges, clamped and quantized. One 256-channel remote pool distributes the joint output vector across the included devices.

See the [technical specification](../docs/TECHNICAL.md) and [operating guide](../docs/OPERATING.md).
