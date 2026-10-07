# Receiver v2 validation — 2026-10-07

## Passed

- Executed the **actual shipped `glove_dual_engine.js`** inside a Node VM with stubs for Max's `Task`, `outlet`, `arrayfromargs` and a controlled clock. Ten checks passed: original raw calibration, independent right-hand input and clipping, malformed packet rejection, deadband jitter suppression, monotone time-correct smoothing, held-target convergence, exact endpoints and no duplicate idle frames, stale hold and recovery, bypass modes, isolated manual engine messages, and frame flushing. The test file groups convergence/endpoint assertions in one check, for a total of ten.
- Read every embedded patcher recursively and checked object IDs and connections. Verified ten embedded `live.map @strict 1` objects with persistent mapping enabled, globally unique Live parameter names and ten normalized `live.remote~` targets.
- Checked both UDP receive ports and both raw/normalized route paths, the same engine output feeding each five-value Max bus, UI unpacker and OSC gate, and both OSC prefixes.
- Checked independent left/right stereo `plugin~` → `plugout~` connections.
- Checked all presentation controls fit **808 × 169** pixels and have no rectangular overlap. Exported the hand graphics from the actual jsui source and visually reviewed the layout preview.
- Verified the AMXD audio-effect header and payload length, and parsed its JSON payload to confirm exact equality with the editable `.maxpat` source.
- Preserved original published device/model/helper hashes; the original release audit still passes.

## Scope of the checks

The VM verifies the processing algorithm, not Max's JavaScript engine or actual UDP transport. `layout-preview.png` and `.svg` reproduce the shipped vector drawing and presentation geometry with illustrative native controls; **they are not screenshots of Ableton Live**.

Native app control timed out for both installed Max instances, access to the Live UI was unavailable, and the installed MaxMCP endpoint on localhost:7400 was not running. Consequently the following have **not** been verified in the host:

- Opening this AMXD and resolving companion JS in Max/Live.
- Actual UDP receive/forwarding and OSC encoding under Max.
- Ten Live parameter assignments, unmapping, set reload, reordering and duplicate-device behavior.
- Destination/filter parameter recall, native theme rendering and audio pass-through while hosted.
- End-to-end latency and behavior with either physical glove.

## Reproduce offline checks

```sh
python3 tools/build.py
python3 tools/test_patch.py
node tools/test_engine.js
node tools/export_layout.js
```

The builder expects the installed Cycling '74 `liveui.map.maxpat` under `/Applications/Max.app/Contents/Resources/C74/packages/Max for Live/patchers/`. The engine tests do not depend on that installation.

## Live acceptance procedure

1. Keep the three runtime files together; load the AMXD on an audio track and check the Max console for missing-file/object errors. Confirm stereo input reaches both output channels.
2. Send `/servos 90 99 99 99 125` to UDP 7000 and then to 6000. Each hand should read 0.500 independently. Confirm `receive GLeft` and `receive GRight` receive five-value lists in pinky-to-thumb order.
3. Send normalized frames alternating 0.500 and 0.502 on one finger: with Deadband 0.003, the accepted output should stay at the initial value. Step to 1.000 and confirm a Smooth 30 ms transition. Disable Stabilize and confirm direct response.
4. Map all ten fingers to ten distinct Live parameters, test 0 and 1 endpoints, then click each × and verify that the target is released. Save/reopen the set and verify assignments and destination/filter settings.
5. Receive OSC at a separate destination port, enable OSC Out and confirm `/GLeft` and `/GRight`, each with five values matching the Max buses. Change destination with Apply. Stop incoming packets for over one second and confirm HOLD retains the last state.

The supplied demo sender (`tools/send_demo.py`) produces synthetic normalized data to localhost; it does not read the glove. Use its `--raw` option for the calibration example above. Disable other receivers before testing the same input ports.
