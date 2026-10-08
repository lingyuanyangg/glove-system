# Receiver v2 validation — 2026-10-08

## Passed

- Executed the **actual shipped `glove_dual_engine.js`** inside a Node VM with stubs for Max's `Task`, `outlet`, `arrayfromargs` and a controlled clock. Fifteen checks passed: original raw calibration, independent right-hand input and clipping, malformed packet rejection, deadband jitter suppression, monotone time-correct smoothing, held-target convergence, exact endpoints and no duplicate idle frames, stale hold and recovery, bypass modes, isolated manual engine messages, and frame flushing. The test file groups convergence/endpoint assertions in one check, for ten original checks, plus two fresh-input bus checks and three control/UI latency checks.
- Read every embedded patcher recursively and checked object IDs and connections. Verified ten embedded `live.map @strict 1` objects with persistent mapping enabled, globally unique Live parameter names and ten normalized `live.remote~` targets.
- Checked both UDP receive ports and both gated raw/normalized route paths, USB-native serial/controller/menu connections, independent engine outlets feeding each five-value Max bus, monitor unpacker, control unpacker and OSC gate, and both OSC prefixes.
- Checked independent left/right stereo `plugin~` → `plugout~` connections.
- Checked all main presentation controls fit **808 × 169** pixels; the independent USB settings window fits **580 × 80** pixels. Neither layout has rectangular overlap. Exported the hand graphics from the actual jsui source and visually reviewed the layout preview.
- Verified the AMXD audio-effect header and payload length, and parsed its JSON payload to confirm exact equality with the editable `.maxpat` source.
- Preserved original published device/model/helper hashes; the original release audit still passes.

- Executed the actual USB controller together with the actual engine in a Node VM with simulated Max serial/status/menu/Task peers. **35 checks** passed: closed startup and recall; named port enumeration, selection and refresh; 115200 8N1 Open; OSC isolation; exact decimal framing; split packets and initial synchronization; malformed/overflow/binary/newline rejection and recovery; partial-frame timeout; hand routing and calibration; stationary two-hand training streams; read/write counters; firmware error reporting; lost data; port reordering/removal/open fallback/native errors/watchdogs; mode changes; instance isolation; momentary buttons; Close/disposal. These simulated controller tests do not open an OS serial port. Two additional checks cover native button bang commands and diagnostic counters/stale status without artificial hand freshness.
- Confirmed fresh GLeft/GRight output for stationary real-input frames, with no manufactured heartbeat after source loss and no additional change-driven UI/OSC chatter. Overdue, malformed and cancelled pending frames do not refresh those buses.

## Scope of the checks

The VM verifies the processing algorithm, not Max's JavaScript engine or actual serial/UDP transport. `layout-preview.png` / `.svg` and `usb-settings-preview.png` / `.svg` reproduce the shipped vector drawing and presentation geometry with illustrative native controls; **they are not screenshots of Ableton Live**.

Native app control timed out for both installed Max instances, access to the Live UI was unavailable, and the installed MaxMCP endpoint on localhost:7400 was not running. Consequently the following have **not** been verified in the host:

- Opening this AMXD and resolving companion JS in Max/Live.
- Actual USB port enumeration/open/close, callback format and timing, firmware framing/serial throughput, cable removal and Arduino reset behavior.
- Actual UDP receive/forwarding and OSC encoding under Max.
- Ten Live parameter assignments, unmapping, set reload, reordering and duplicate-device behavior.
- Destination/filter parameter recall, native theme rendering and audio pass-through while hosted.
- End-to-end latency and behavior with either physical glove.

## Reproduce offline checks

```sh
python3 tools/build.py
python3 tools/test_patch.py
node tools/test_engine.js
node tools/test_usb.js
node tools/export_layout.js
```

The builder expects the installed Cycling '74 `liveui.map.maxpat` under `/Applications/Max.app/Contents/Resources/C74/packages/Max for Live/patchers/`. The engine tests do not depend on that installation.

## Live acceptance procedure

1. Keep the four runtime files together; load the AMXD on an audio track and check the Max console for missing-file/object errors. Confirm stereo input reaches both output channels.
2. Send `/servos 90 99 99 99 125` to UDP 7000 and then to 6000. Each hand should read 0.500 independently. Confirm `receive GLeft` and `receive GRight` receive five-value lists in pinky-to-thumb order.
3. Send normalized frames alternating 0.500 and 0.502 on one finger: with Deadband 0.003, the accepted output should stay at the initial value. Step to 1.000 and confirm a Smooth 8 ms transition. Disable Stabilize and confirm direct response.
4. Map all ten fingers to ten distinct Live parameters, test 0 and 1 endpoints, then click each × and verify that the target is released. Save/reopen the set and verify assignments and destination/filter settings.
5. For USB, upload the provided firmware to an actual UNO R4 WiFi with the documented pin wiring. Select USB, open USB… settings, Refresh, select its port and Open. Confirm L/R angles match calibration, and that stable poses continuously reach GLeft/GRight. Test bad frames, missing hands, Close, input-mode changes, occupied/missing ports, disconnect/reconnect, saved Set recall and two-second gesture recordings. The connection must remain closed after recall.
6. Receive OSC at a separate destination port, enable OSC Out and confirm `/GLeft` and `/GRight`, each with five values matching the Max buses. Change destination with Apply. Stop incoming packets for over one second and confirm HOLD retains the last state.

The supplied demo sender (`tools/send_demo.py`) produces synthetic normalized data to localhost; it does not read the glove. Use its `--raw` option for the calibration example above. Disable other receivers before testing the same input ports.

## 2026-10-08 live fault investigation

macOS and Arduino CLI identify `/dev/cu.usbmodem90706920872C2` as UNO R4 WiFi. No process held the port at inspection. A raw 115200/8N1 diagnostic read for six seconds received **zero bytes** before the firmware correction. This cannot establish actual glove UART activity. The installed receiver files matched the published release. Native Max UI inspection again timed out, so the on-screen console and actual button/port operation have not been verified.

Source inspection found two concrete issues: the target UART's inherited zero availableForWrite() suppressed all Arduino output, and the USB… live.text button emits bang but the old opener selected numeric 1. Both are corrected. Firmware diagnostics now distinguish board transport, UART byte arrival and valid frame counts without refreshing hand streams.

## Receiver latency optimization — 2026-10-08

- The user reported that both numeric displays and mapped parameters lagged. Live owns the actual Arduino USB port during this review; it was not interrupted or read by a second program. The connected board was not flashed, reset or reconfigured.
- Background native serial reading and 2ms polling replace 5ms polling. Byte grouping follows the reported read count before bytes arrive, with native per-byte deferral disabled and FIFO deferral applied only to complete groups/statuses.
- Five additional controller/graph assertions verify latest-per-hand burst reduction, Right-fault cancellation within a burst, exact native read-sized grouping and partial-frame continuation, no JS traffic from 1000 empty polls, FIFO batch ordering, port acknowledgement order and rejection of queued data after Close. These execute the shipped controller and walk the shipped graph with documented native-object peers; actual Max thread timing is not emulated.
- Three engine regressions verify the new default 8ms filter/5ms tick reaches 95% at 25ms in the controlled clock model, immediate mapped control/fresh buses despite delayed painting, and at most approximately 30 monitor updates/second under 200Hz input while preserving all control updates. First valid frames are still immediate. Deadband is retained.
- Existing fresh-input tests continue to pass: stable two-hand poses refresh learning consumers, malformed/stale/faulted data do not, and neither UI-only painting nor board diagnostic packets create learning heartbeats.

**50 logic checks** (15 engine + 35 USB/graph) and the recursive patch/AMXD/mapping/layout check pass. Companion files, release hashes and packaged installation are checked separately. No end-to-end latency improvement, actual native grouping callback format, audio-buffer behavior or on-screen response has been measured in the host; report only nominal intervals and model response, not a measured hardware latency target.

For host acceptance, reload this AMXD, reopen USB, set Smooth to 8ms or 0ms explicitly if the Set restores 30ms, and compare both hands in Stabilize-off and enabled modes. Verify numbers, all mappings and fresh regression/classification input, including under normal Live session load. Old and new full system latency should be measured with the same audio buffer and glove conditions if exact timing is required.
