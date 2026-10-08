# Glove Neural Scope — FluCoMa validation, 2026-10-08

## Checks completed

- **Native core:** compiled and executed the official **FluCoMa core tag 1.0.9** (`da9e6ac697551c24138711688546a78d4780425b`), with Eigen 3.4.0 and foonathan memory 0.7-3. Four native activation functions and matrix/bias restore agree with an independently accumulated prediction to 1e-12 before float-buffer conversion. Synthetic SGD training converged for 5-input/10-output, 10-input/10-output and 10-input/256-output mappings. A 512-example/256-output boundary case remained finite. Error scaling was checked against independently measured squared error. Five result records are in `validation/native-core.json`; these are **standalone native-library tests, not Max or Live host tests**. They do not benchmark hand-to-sound latency or compare speed against Data Knot.
- **40 adapter/protocol checks** execute the shipped Max JS with a simulated Live Object Model, Buffer/Dict peers and native messages. Coverage includes target/Rack discovery, track following, 5/5/10 hand routing, capture, native dataset load gating, native fit/dump sequencing, saved-model recall, remote acquisition/release, clamps/quantization, independent banks, topology changes, model selector, JSON import/export, malformed inputs, Unicode names, ID rematching, version-one/version-two state, cancellation, stale native responses, frame coalescing, missing-external diagnostics, timeouts, large data transport and raw FluCoMa imports. The protocol fixture uses endpoint model weights to test message behavior; it does **not** implement or measure a neural optimiser.
- **Six format checks** validate native layer shape, all four activation codes, unchanged model serialization, non-finite data rejection, Data Knot import and absence of a JavaScript neural trainer/predictor. Results: `validation/format.json`.
- **Ten HTML function/logic checks** cover fragmented table messages, stale/duplicate packets, malformed messages, light/dark themes, model selector states and missing-FluCoMa training/Run controls. These are JavaScript checks, not a rendered UI review. Results: `validation/ui.json`.
- Structural checks verify stereo pass-through, both Max buses, 256 fixed native remotes, theme/Blob bridges, a pair of native `fluid.mlpregressor~` objects, paired `fluid.dataset~` objects, native buffers, per-instance `#0` names, both result/dump outlets with deferred callbacks, import/export dialogs, companion dependencies and exact AMXD/source equality. Generated controller and HTML scripts pass syntax checks. No default model JSON is present.
- Protocol and model serialization were checked against the installed FluCoMa **1.0.9** documentation/help patches and its official Max wrapper/core source. Fit completion includes the two dataset-name tokens before the error; model load/dump complete through the dump outlet. The bridge handles both outlets and waits for load acknowledgements before inference.

## Native host boundary

No new Live or Max UI test was completed. Earlier Live app control was not approved, and the browser preview permission was declined. No alternate browser, hidden UI access or application-control workaround was attempted. The native C++ test runs only the library in a command-line executable.

The actual AMXD must still be checked in Live for package resolution, Max Buffer/Dict behavior, native callback ordering, companion assets, theme rendering, the large editor, glove transport, parameter mapping, Set recall and stereo audio. No performance or stability guarantee in Live is inferred from offline results.

## Reproduce

```sh
python3 tools/build.py
node tools/test_format.js
node tools/test_adapter.js
node tools/test_ui.js
python3 tools/test_patch.py
```

For the separate native-core check, obtain official FluCoMa core tag 1.0.9, Eigen tag 3.4.0 and foonathan memory tag v0.7-3. Build the memory static library with CMake (tests/examples off), then run:

```sh
python3 tools/test_native.py --core /path/to/flucoma-core --eigen /path/to/eigen \
  --memory /path/to/memory --memory-build /path/to/memory-build
```

The runner uses clang++/C++17 and writes `validation/native-core.json`. Those third-party sources/libraries are not bundled.

## Live acceptance

1. Install FluidCorpusManipulation 1.0.9 or later in Max Package Manager. Reload the AMXD with its controller JS and HTML beside it. Confirm the UI reports FluCoMa readiness, no missing objects, and stereo pass-through.
2. Receive actual `GLeft`/`GRight` frames. Test Left, Right and Both, including a missing hand. Select/pin/follow a target, scope parameters, Capture different poses/sounds, Train and Run. Check native fit progress, Stop and output smoothing.
3. Cancel training and switch target/mode/scope while a request is pending. Verify old callbacks do not take over a new target. Test quantized parameters, unavailable parameters and target deletion.
4. Save named models, load different scopes/bounds, export/import JSON, and import a raw FluCoMa model. Verify wrong hand/target structure blocks Load. Existing earlier snapshots should retain their weights/examples without retraining.
5. Save/reopen a Set, including an earlier version-two Set. Verify the model selector, banks and settings return with Run off; review target identity after reordering. Check light/dark themes and the large editor.
