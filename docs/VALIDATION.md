# Validation record

Review date: **2026-10-06**.

The new dual-hand receiver's **2026-10-08** algorithm, patch structure and layout checks are recorded in [Receiver v2 validation](../receiver-v2/VALIDATION.md). Its calibration/range/raw-inspection revision passes 26 engine, 38 USB and 10 native mapper graph checks plus structural/AMXD/layout verification; actual calibration accuracy, native mapping behavior and saved Set recall still require host testing. The record below applies to the original release. The former default model was removed on 2026-10-07 at the project owner's request; its inspection results below are historical. The new FluCoMa backend's 2026-10-08 native-core and protocol checks are recorded in [Glove Neural Scope validation](../neural-scope/VALIDATION.md).

The **2026-10-08 Glove Gesture classifier** adds six original hand illustrations, Left/Right/Both training banks, native FluCoMa classification, a single-pose main UI, independent training dropdowns, mixed-hand combinations and a separate 48-slot Mapping window, temporal/distance filtering and named model import/export. Its standalone native algorithm, simulated controller/UI and patch results are recorded in [classification validation](../gesture-classification/VALIDATION.md). Actual glove accuracy, button behavior and mapping recall in Live remain untested.

The project owner identified the glove hardware as the **ElastremeSense Manu-5D e-skin data glove kit**. This identification has been added to the documentation; it does not change the firmware or constitute a hardware compatibility test.

## Checks completed

- Read the complete supplied Arduino sketch and inspected the JSON patch payloads inside all four `.amxd` containers, including nested subpatches and patch cords.
- Copied all four device binaries without modification. Their hashes and saved Max versions are recorded in [`file-manifest.json`](file-manifest.json).
- Extracted readable `.maxpat` sources directly from the device payloads; no device logic was regenerated.
- Located `unitPart.maxpat` in the local `brainMapper Project` and included an unchanged copy. It contains the parameter assignment logic required by both mapping devices.
- Located and inspected the CNMAT MMJ Depot `delta` abstraction used by the MIDI detector. It remains an external package dependency.
- Inspected the locally installed Data Knot **1.0.3** reference files and regressor implementation, including `rawlist` output, training controls, and FluCoMa usage.
- Checked paired model rows, input/output dimensions, layer matrices, biases, and activation codes.
- Removed real Wi-Fi credentials from the release sketch, replaced the destination IP with a placeholder, and translated comments to English. Executable processing logic was preserved.
- Compiled the release sketch successfully with Arduino CLI for `arduino:renesas_uno:unor4wifi` using UNO R4 Boards **1.6.0**, Servo **1.2.1**, and CNMAT OSC **1.3.7**.

Compiler result:

```text
Sketch uses 64176 bytes (24%) of program storage space.
Maximum is 262144 bytes.
Global variables use 9572 bytes (29%) of dynamic memory,
leaving 23196 bytes for local variables. Maximum is 32768 bytes.
```

The compile used the locally available Servo library explicitly through Arduino CLI's `--libraries` option. Compilation confirms build compatibility in that environment; it does not validate physical operation.

## Reproducible offline checks

From the repository root:

```sh
python3 tools/audit_release.py
arduino-cli compile --fqbn arduino:renesas_uno:unor4wifi arduino/glove
```

The audit checks file integrity, matching extracted patch sources, patch-cord references, expected dependency counts, removal of the former default model, and the original firmware processing logic. The compile command assumes the required libraries are installed in a location visible to Arduino CLI.

## Checks still requiring hardware or host access

| Area | Remaining check |
| --- | --- |
| Glove input | Confirm the Manu-5D kit's acquisition/transmission setup, external Bluetooth/UART source, channel order, cadence, and voltage levels. |
| Servo control | Confirm power, mechanical range, direction, initialization pose, and behavior when input stops. |
| OSC | Capture live `/servos` packets and localhost forwarded packets; measure update rate and delivery under load. |
| Ableton Live | Load each device, verify dependencies and parameter assignment, and save/reopen a set. |
| MIDI | Capture note-on and scheduled note-off output, randomization, movement thresholds, and burst timing. |
| Regression | Verify package model loading, predictions, clipping, training export/reload, and unseen poses. |

No latency, packet-loss, model accuracy, or Live compatibility benchmark is claimed. No firmware was uploaded and no actuators were operated during this review.

## Known limitations preserved

The serial parser is permissive, buffer overflow can retain a partial frame suffix, there is no serial-loss parking behavior, and Wi-Fi has no explicit retry loop. `GLeft` is a shared bus. The receiver does not pass audio through. MIDI movement detection has no hysteresis or edge debounce. Mapping persistence uses runtime parameter IDs and needs host verification. Training does not automatically update the inference object.
