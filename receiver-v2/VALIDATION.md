# Receiver v2 validation — 2026-10-08

## Current release checks

- Executed the **actual shipped `glove_dual_engine.js`** inside a Node VM with stubs for Max's `Task`, `outlet`, `arrayfromargs` and a controlled clock. **26 checks** pass: 15 filtering/freshness/latency checks, seven calibration regressions, two raw-inspection checks and two source-routing checks.
- Read every embedded patcher recursively and checked object IDs and connections. Verified that Receiver contains **zero** live.map/live.remote~ objects. Ten persistent native mapping components now belong to the separate Mapper, with their own structural and range checks.
- Checked both UDP receive ports and both gated raw/normalized route paths, USB-native serial/controller/menu connections, independent engine outlets feeding each five-value Max bus, monitor unpacker, independent Mapper control bus and OSC gate, and both OSC prefixes.
- Checked independent left/right stereo `plugin~` → `plugout~` connections.
- Checked all main presentation controls fit **648 × 169** pixels; the independent USB settings window fits **580 × 80** pixels and each calibration window fits **440 × 222**. Presentation controls have no rectangular overlap; hand art is an intentional background. Exported the hand graphics from the actual jsui source and visually reviewed the main/calibration previews.
- Verified the AMXD audio-effect header and payload length, and parsed its JSON payload to confirm exact equality with the editable `.maxpat` source.
- Preserved original published device/model/helper hashes; the original release audit still passes.

- Executed the actual USB controller together with the actual engine in a Node VM with simulated Max serial/status/menu/Task peers. **38 checks** passed: closed startup and recall; named port enumeration, selection and refresh; 115200 8N1 Open; OSC isolation; exact decimal framing; split packets and initial synchronization; malformed/overflow/binary/newline rejection and recovery; partial-frame timeout; hand routing and calibration; stationary two-hand training streams; read/write counters; firmware error reporting; lost data; port reordering/removal/open fallback/native errors/watchdogs; mode changes; instance isolation; momentary buttons; Close/disposal. These simulated controller tests do not open an OS serial port. Two additional checks cover native button bang commands and diagnostic counters/stale status without artificial hand freshness.
- Confirmed fresh GLeft/GRight output for stationary real-input frames, with no manufactured heartbeat after source loss and no additional change-driven UI/OSC chatter. Overdue, malformed and cancelled pending frames do not refresh those buses.

## Scope of the checks

The VM verifies the processing algorithm, not Max's JavaScript engine or actual serial/UDP transport. `layout-preview`, `usb-settings-preview` and `calibration-preview` PNG/SVG files reproduce the shipped vector drawing and presentation geometry with illustrative native controls; **they are not screenshots of Ableton Live**.

Native app control timed out for both installed Max instances, access to the Live UI was unavailable, and the installed MaxMCP endpoint on localhost:7400 was not running. Consequently the following have **not** been verified in the host:

- Opening this AMXD and resolving companion JS in Max/Live.
- Actual USB port enumeration/open/close, callback format and timing, firmware framing/serial throughput, cable removal and Arduino reset behavior.
- Actual UDP receive/forwarding and OSC encoding under Max.
- Ten Live parameter assignments, unmapping, set reload, reordering and duplicate-device behavior.
- Destination/filter parameter recall, native theme rendering and audio pass-through while hosted.
- Calibration button operation and endpoint recall in an actual saved Set, native Min/Max widgets and their target-unit signal output in Live.
- End-to-end latency and behavior with either physical glove.

## Reproduce offline checks

```sh
python3 tools/build.py
python3 tools/test_patch.py
node tools/test_engine.js
node tools/test_usb.js
node tools/test_mapping.js
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
7. With fresh glove input, open each Calibrate window. Hold open for 0.3s and capture Open, then hold fist and capture Fist. Verify 0.000/0.900 per finger and permitted clipping at 1.000, both sensor directions, hand independence, rejection of stale/moving/insufficient-span captures and Reset. Confirm no replayed learning frames after a calibration change. Save/reopen and verify completed endpoints; USB must still start closed.
8. Set a mapped finger's Min/Max to 20%/80%; verify open = 20%, fist = 74%, headroom = 80% of the target range. Test inverted and equal endpoints, targets with different actual ranges, target reassignment and Set recall. Confirm GLeft/GRight and OSC remain calibrated 0–1 regardless of mapping range.

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

## Pose calibration and native Mapping ranges — 2026-10-08

- Seven new engine checks exercise independent per-finger raw/normalized endpoints, positive and negative spans, open = 0 and fist = 0.9 with clipping/headroom, fresh stationary capture averaging, minimum span, atomic replacement, malformed JSON recall, source-format changes, stream reset, hand-specific clearing and preservation of low-latency filtering. Capture/restore do not manufacture learning frames from old input.
- Ten native mapping checks interpret the actual embedded `p Scale` graph's control arithmetic and signal path. All fingers pass for full range, 20–80% with fist/headroom, inversion, equal endpoints, clipped input, native targets in [-70,6] and [20,20000], and a changed target range. These are documented-object simulations, not Max DSP or Live API executions.
- The structural check verifies both calibration popups, momentary bang-to-message commands, status routing, bound calibration state, native visible percentage controls, native target-range wiring and absence of the old direct signal-to-remote bypass. Existing Map parameter names are preserved.
- **67 logic/graph checks** pass (22 engine + 35 USB + 10 native mapping), plus the recursive patch/AMXD/parameter/layout check. A local backup of the installed pre-calibration receiver was retained. No firmware upload or serial-port interruption was performed.

Real glove calibration accuracy, native widget rendering and saved Set recall remain host acceptance items. Model training must use the same calibration as inference; previously trained models are not automatically converted by this receiver update.


## Right-hand transport and raw inspection — 2026-10-08

The user reports greater Right lag and a thumb value near 0.3, and confirms pose calibration has not yet been performed. The owner subsequently resolved the data issue and requested focus on Right latency; no further sensor-range changes were made. No physical input has been captured in this revision and no firmware has been uploaded by the agent.

- The Calibrate popup now exposes all five original incoming values before receiver calibration/deadband/smoothing, plus staged/saved Open/Fist endpoints. Cached diagnostic updates are capped at 5Hz, routed separately and do not drive controls or learning buses. Its fresh/stale label measures Max arrival only, not sensor acquisition time.
- Two engine checks demonstrate raw Right thumb 103 degrees alongside fallback output 0.3, endpoint inspection, stale/no-data labels, retained saved endpoints, limited refresh and absence of artificial bus frames. Two USB integration checks preserve the same raw value from the serial adapter and validate USB3 bad-frame/queue fields while maintaining USB2 compatibility.
- USB3 diagnostics report cumulative UART counters and observed queue peaks, also when hand data is live. They cannot detect every valid-looking corrupted frame, native overflow, Bluetooth backlog or end-to-end latency.
- **74 receiver logic/graph checks** pass: 26 engine + 38 USB + 10 native mapping. Recursive graph/AMXD/parameter/layout checks pass. Both native popup layouts and calibration inspection labels were reviewed in illustrative previews, not Live screenshots.
- The paired firmware's software-input queue change and optional D12 hardware UART compile results are documented in its own VALIDATION.md. Updating the receiver alone does not update Arduino firmware. A cause is not considered confirmed until actual raw observations and the input-path comparison are performed.


Swap L/R tests cover both raw and normalized routing, correct fresh bus outlets, physical Right-fault propagation, input labels, preserved physical-source calibration and recall ordering. The toggle is neutral/off by default. A generated, ready-to-upload hardware variant matches the shared source except for the selected mode and wiring comments and also compiles independently (55716 flash bytes / 8768 static RAM bytes). No new physical-port opening or flashing was performed.

## Receiver / Mapper split — 2026-10-08

Removed all ten mapping subpatchers, signals and remotes from Receiver. Presentation now fits 648 × 169 with no control overlap. Replaced the static outline with five independent animated curl capsules per hand, an open reference silhouette and 0–1 meters with a 0.9 fist marker. USB/controller/engine code is unchanged; 26 engine and 38 USB regressions still pass. The native mapping arithmetic checks moved to mapper/tools.

Added separate change-driven GLeftControl/GRightControl sends from existing engine control outlets, preserving smoothing ticks for the independent Mapper without changing GLeft/GRight physical-frame freshness. The Mapper's graph check covers both paths.

For this revision, Live UI access succeeded. Loaded both final installed devices on the existing empty fourth audio track. Synthetic normalized OSC values appeared correctly in both devices, with spatially mirrored Right artwork and responsive per-finger meters/curl. HOLD was observed after incoming packets stopped. The Mapper's native Pan assignment, correct target range scaling and × release were exercised; see mapper/VALIDATION.md. Temporary mapping was removed, Pan restored to 0/C and synthetic values cleared. Both devices remain loaded with USB closed; the user's Set was not saved. Actual glove/USB operation, calibration captures, saved Set state migration/recall and audio fidelity were not tested in this revision. Earlier entries above describe historical versions and host-access limitations at those dates.
