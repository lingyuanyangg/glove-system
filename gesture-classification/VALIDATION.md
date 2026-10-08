# Glove Gesture validation — 2026-10-08

## Completed checks

- **10 logic checks:** normalized finite 5/10-dimensional input, independent bank defaults, native classifier label/layer validation, snapshot identity, sample limits, RMS feature distance, stable Hold, single entry, jitter, cooldown, Other release and gaps between observations. This code manages data/temporal filtering and has no JavaScript neural optimizer or predictor.
- **27 adapter/protocol checks:** execute the shipped controller with simulated Max Buffer/Dict/Task/File peers and a simulated Live Object Model. They cover fresh two-second recording and trial IDs; left/right/both routing and synchronization; class minimums; paired DataSet/LabelSet load acknowledgements; native fit/dump ordering; model load gating and pending-frame coalescing; toggles/pulses/holds/on/off; distance rejection; Stop/loss/remap/manual overrides/shared targets; invalid/deleted/disabled/non-button targets; cancellation/stale replies; independent banks; named models; Unicode import/export; Set state; malformed files; missing external/watchdog behavior; and disposal. The native fixture supplies labels and model weights only to test the message protocol. It does not perform neural training.
- **10 UI function checks:** run the actual HTML script with a minimal simulated DOM. They cover all six embedded SVGs and controls, left mirroring/right orientation/paired drawings, native readiness, recording/training controls, confirmed cards/target hints, compatible model selection, packet assembly/stale/duplicate rejection, malformed state, theme derivation and command encoding. This is not browser rendering or a Live UI test.
- **Three native-core result records:** compiled and executed the official **FluCoMa core 1.0.9** (`da9e6ac697551c24138711688546a78d4780425b`) MLP, SGD and LabelSetEncoder algorithms with Eigen 3.4.0 and foonathan memory 0.7-3. Synthetic seven-class 5→8→7 and 10→16→7 networks trained for 500 epochs with the runtime's activation/optimizer settings and chunk sizes. Both classified all 140 separately generated synthetic test points correctly. Encoder label ordering and restored matrix/bias predictions agree to 1e-12 before float-buffer conversion. **These synthetic results are not real-glove accuracy or a Max/Live host test.** They do not benchmark end-to-end latency or classify sensor data recorded from the user.
- **Patch/package structure:** AMXD/source semantic equality and binary envelope; valid patch endpoints; two native MLPClassifier objects, DataSet/LabelSet and instance-named buffer; both native result/dump outlets deferred to the controller; six embedded native Map components with persistence; unique parameter names; all event buses; stereo pass-through; layout bounds; SVG parsing; exact JS source concatenation and packaged companions. Generated JS and HTML scripts pass syntax checks.
- **Art inspection:** the six SVG illustrations were rasterized with Sharp and visually checked as a contact sheet. Their hand poses are distinguishable as intended. This is an artwork review, not a screenshot of Live or the HTML layout.
- Message behavior and classifier JSON shape were checked against the installed **FluidCorpusManipulation 1.0.9** reference/help files and official wrapper/core source. Dataset/labelset/model load acknowledgements use the dump outlet; fit/predictpoint results contain argument tokens before their returned value. Native MLPClassifier serialization is `{mlp, labels}`, including the encoder's label order.

Result records are in `validation/logic.json`, `adapter.json`, `ui.json` and `native-core.json`.

## Host boundary

No new Max or Live application-control test was completed. Earlier Live control and browser preview were not approved; no alternate browser, hidden UI access or app-control workaround was attempted. The native C++ check is a standalone command-line program.

Still unverified: actual package/object resolution, Max Dict/Buffer/File behavior, native callback timing, companion/help loading, Jweb/theme layout, Map targeting and persistence, audio pass-through, automation interaction and classifications from real gloves. No real accuracy, latency or Live compatibility guarantee is inferred from offline checks.

## Reproduce

```sh
python3 tools/build_art.py
python3 tools/build.py
node tools/test_logic.js
node tools/test_adapter.js
node tools/test_ui.js
python3 tools/test_patch.py
```

Building requires the installed native `liveui.map.maxpat` at the path in `tools/build.py`; the published runtime already embeds it. For the optional standalone native check, obtain FluCoMa core tag 1.0.9, Eigen 3.4.0 and foonathan memory tag v0.7-3, then build the memory static library:

```sh
python3 tools/test_native.py --core /path/to/flucoma-core --eigen /path/to/eigen \
  --memory /path/to/memory --memory-build /path/to/memory-build
```

This uses clang++/C++17 and writes `validation/native-core.json`. Third-party source checkouts and compiled libraries are not bundled.

## Live acceptance

1. Load the AMXD with all companion files beside it. Confirm native readiness, the guide, light/dark themes, six images, native Map controls and clean stereo audio.
2. Test Left/Right/Both, asynchronous arrivals, missing hands, invalid frames and receiver calibration. Record each enabled pose and Other over separate repetitions. Verify counts/trial IDs and cancellation.
3. Train and evaluate new real-glove trials without actions mapped. Record a confusion table including transitions/unknown poses, particularly Index/V/Middle/OK. Check whether finger-bend data distinguishes your OK pose. Tune Hold/Gap/Radius against false triggers and responsiveness.
4. Map actual two-state parameters. Test Toggle, Pulse, Hold, On, Off; repeat held poses; Stop; input loss; remap; manual edits; shared targets; disabled/deleted targets and Live automation. Confirm only temporary states are released.
5. Save/load named models and JSON. Save/reopen a Set and rearrange mapped devices; confirm native ID rematching, banks/actions/settings, and that Run returns off. Listen to all three event buses for matching enter/exit behavior.
