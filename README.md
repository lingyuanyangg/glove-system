# Glove System — Arduino, OSC & Max for Live

A five-channel glove interface for musical performance in Ableton Live, based on the **ElastremeSense Manu-5D e-skin data glove kit**. The system combines Arduino servo control, OSC over Wi-Fi, continuous parameter mapping, gesture-triggered MIDI notes, and a learned mapping from five glove values to ten control outputs.

This repository contains the Arduino bridge firmware, four original Max for Live devices, a rebuilt dual-hand receiver, readable Max patch sources, and an example regression model. The firmware receives glove data from an **external serial source**; the glove sensor acquisition firmware and Bluetooth transmitter are outside this release.

The new [**Glove Receiver Dual**](receiver-v2/README.md) adds right-hand reception on UDP **6000**, ten native Live mapping controls, two vector hand drawings, adjustable deadband and time smoothing, shared `GLeft` / `GRight` buses, and configurable OSC forwarding to `/GLeft` / `/GRight`. Left-hand reception remains on **7000**. Its audio path passes stereo through unchanged. The algorithm and patch structure are verified; operation and mapping recall in Live still require host testing.

```mermaid
flowchart LR
    G[ElastremeSense Manu-5D e-skin data glove kit] --> I[External acquisition / serial source]
    I -->|UART: five integers| A[Arduino UNO R4 WiFi]
    A --> S[Five servo outputs]
    A -->|OSC /servos · UDP 7000| R[Glove Receiver Dual]
    A2[Right-hand bridge] -->|OSC /servos · UDP 6000| R
    R --> F[Deadband + time smoothing]
    F -->|Ten normalized values| L[Native Live parameter mapping]
    F -->|Normalized five-value list · GLeft| D[Direct parameter mapping]
    F -->|GLeft| B[Gesture-triggered MIDI]
    F -->|GLeft| M[5-input / 10-output regression]
    F -->|OSC /GLeft + /GRight · configurable IP and port| X[External application]
```

## Included modules

| File | Role |
| --- | --- |
| [`Glove_Receiver_Dual.amxd`](receiver-v2/Glove_Receiver_Dual.amxd) | New dual-hand audio effect: left 7000, right 6000; ten 0–1 displays and native mappings; jitter filtering; Max buses and optional OSC output. Keep its two companion JavaScript files alongside it. |
| [`arduino/glove/glove.ino`](arduino/glove/glove.ino) | Reads five comma-separated integers from `Serial1`, controls five servos, and sends one `/servos` OSC message per processed frame. |
| [`GloveRecevier.amxd`](max/devices/GloveRecevier.amxd) | Receives UDP port 7000, routes `/servos`, displays values, normalizes each channel to 0–1, and publishes the list on `GLeft`. Also forwards individual channels to localhost port 8000. |
| [`Glove_Direct_Map.amxd`](max/devices/Glove_Direct_Map.amxd) | Five independent parameter mapping rows driven by the normalized glove channels. Stereo audio passes through unchanged. |
| [`Glovebang.amxd`](max/devices/Glovebang.amxd) | Five movement detectors drive MIDI notes, with optional randomized pitch and duration and probabilistic note bursts. |
| [`reressorMapping2.amxd`](max/devices/reressorMapping2.amxd) | Uses a Data Knot regressor to convert the five-channel glove list into ten parameter mapping values. Includes training controls in the patch editor. Stereo audio passes through unchanged. |
| [`gloveRegressor10.json`](max/devices/gloveRegressor10.json) | Example model containing ten paired training examples and a fitted 5 → 3 → 3 → 10 neural network. |
| [`unitPart.maxpat`](max/devices/unitPart.maxpat) | Shared Live parameter assignment row, recovered from the local `brainMapper Project`. Required by both mapping devices. |

Original device filenames, including `Recevier` and `reressor`, are retained for compatibility. The four `.amxd` files are unchanged copies of the supplied devices.

## Requirements

- **ElastremeSense Manu-5D e-skin data glove kit** — the glove hardware used as the basis of this project. Its acquisition and transmission setup supplies the external data source for the Arduino bridge; that source must output the serial frame format documented below.
- **Arduino UNO R4 WiFi**, with the Arduino UNO R4 Boards package. The sketch uses `WiFiS3`, `WiFiUdp`, **Servo**, and the **CNMAT OSC** library.
- An external UART source producing the documented frame format at **115200 baud**. A Bluetooth-to-UART receiver is one possible source; this sketch does not use onboard Bluetooth APIs.
- Five servos, a suitable servo power supply, and the mechanical glove assembly. Servo specifications, sensor wiring, and mechanical drawings are not included.
- Ableton Live with Max for Live available. The supplied patches were saved with **Max 9.1.3 / 9.1.5**; this is file metadata, not a tested compatibility guarantee.
- **CNMAT MMJ Depot** for the message-rate `delta` abstraction used by `Glovebang`.
- **Data Knot** and **FluCoMa** for the regression device. These packages are external dependencies and are not bundled.

See [installation and troubleshooting](docs/SETUP.md) for dependency links and configuration details.

## Quick start

1. Install the Arduino board package and libraries. Open `arduino/glove/glove.ino` and replace `YOUR_WIFI_SSID`, `YOUR_WIFI_PASSWORD`, and the example destination IP with your local settings. Keep personal credentials out of public commits.
2. Select **Arduino UNO R4 WiFi** and upload the sketch. Configure the external source for `Serial1` at 115200 baud, with frames such as `0,180,180,180,700;`.
3. Keep `receiver-v2/Glove_Receiver_Dual.amxd` and its two JavaScript files together. Drag the AMXD onto an audio track. This new receiver needs only native Max for Live objects.
4. Ensure the left Arduino sends to this computer's LAN IPv4 address on UDP **7000**. Configure the right-hand bridge to send to **6000**. Each hand sends `/servos` with five arguments; finger order is pinky, ring, middle, index, thumb.
5. Click a finger's **Map** control, then click a Live parameter. Adjust **Smooth** and **Deadband** to suppress sensor jitter. Configure output **IP** and **Port**, click **Apply**, and enable **OSC Out** if forwarding is needed.
6. For gesture notes or regression, keep `max/devices/` together and install the relevant packages above. `Glovebang` and `reressorMapping2` consume the filtered left-hand `GLeft` list. Verify calibration before evaluating gestures or training a model.

The legacy `GloveRecevier` has no wired audio pass-through; use a dedicated track if choosing that version. The new Dual receiver passes stereo audio through. `GLeft` and `GRight` are shared across the Max environment, so use one receiver per set and avoid binding two devices to the same UDP port. See the [Dual receiver guide](receiver-v2/README.md) for filtering, input validation and output behavior.

## Data interface

| Stage | Format / range |
| --- | --- |
| External source → Arduino | ASCII `v0,v1,v2,v3,v4;`, 115200 baud. Semicolon ends the frame. |
| Arduino → computer | OSC `/servos` with five integer arguments, nominally 0–180, UDP port 7000. Values are calibrated before servo direction reversal. |
| Receiver → mapping modules | `GLeft`: five floats clipped to 0–1, in the original channel order. |
| Dual receiver → Max / external application | `GLeft` and `GRight` each carry five filtered floats. Optional OSC `/GLeft` and `/GRight` carry the same lists to a configured destination. |
| Legacy receiver → optional external application | Five separate OSC addresses `/glove/finger/0` through `/glove/finger/4`, one normalized float each, to `127.0.0.1:8000`. This branch reverses the channel numbering. |
| Regression → mapping rows | Ten values, displayed and constrained to 0–1 by the output multislider before parameter mapping. |

Exact pin assignments, normalization formulas, channel numbering, gesture logic, and model details are documented in the [technical specification](docs/TECHNICAL.md).

## Repository layout

```text
.
├── README.md
├── arduino/glove/glove.ino        # Sanitized firmware; English comments
├── max/devices/                  # Four original .amxd devices, model, helper
├── max/source/                   # JSON patch sources extracted from .amxd
├── receiver-v2/                  # Dual receiver, companion JS, source and checks
├── docs/
│   ├── SETUP.md                  # Installation, calibration, troubleshooting
│   ├── TECHNICAL.md              # Protocols, signal flow, algorithms
│   ├── VALIDATION.md             # Checks performed and remaining limitations
│   ├── PUBLISHING.md             # GitHub repository upload instructions
│   └── file-manifest.json        # Device hashes and source metadata
└── tools/audit_release.py        # Offline structural and integrity checks
```

## Verification and release status

The sanitized sketch compiled successfully for UNO R4 WiFi using Arduino UNO R4 Boards **1.6.0**, Servo **1.2.1**, and CNMAT OSC **1.3.7**. The device payloads and model structure were inspected, and the release includes the missing parameter mapping helper. See the [validation record](docs/VALIDATION.md) for reproducible checks.

Hardware movement, network delivery, MIDI output, Live parameter assignment, and saved-set recall have **not been tested in this review**. The new receiver passes ten engine checks and recursive patch, mapping, envelope and layout checks; see its [validation record](receiver-v2/VALIDATION.md). The original implementation's parser, connection and mapping limitations remain documented separately.

## Dependencies and credits

- **ElastremeSense Manu-5D e-skin data glove kit** — glove hardware platform used in this project.
- [Arduino UNO R4 WiFi documentation](https://docs.arduino.cc/tutorials/uno-r4-wifi/cheat-sheet/) — board, UART, and Wi-Fi APIs.
- [CNMAT OSC](https://github.com/CNMAT/OSC) — Arduino OSC encoding.
- [Cycling '74 UDP receive documentation](https://docs.cycling74.com/reference/udpreceive/) and [UDP send documentation](https://docs.cycling74.com/reference/udpsend/) — Max network transport and OSC conversion.
- [CNMAT MMJ Depot](https://github.com/CNMAT/CNMAT-MMJ-Depot) — `delta` abstraction.
- [Data Knot, by Rodrigo Constanzo](https://rodrigoconstanzo.com/data-knot/) and [FluCoMa](https://learn.flucoma.org/reference/mlpregressor/) — regression tools.

No project-wide license has been selected for this release. The supplied files and recovered `unitPart.maxpat` do not establish a redistribution license or complete authorship history. Third-party libraries remain subject to their own terms; this repository does not relicense them.
