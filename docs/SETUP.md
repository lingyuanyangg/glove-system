# Installation, calibration, and troubleshooting

## Glove hardware

This project uses the **ElastremeSense Manu-5D e-skin data glove kit** as its glove hardware platform. Set up the kit's sensing and acquisition components using the documentation supplied with your kit, then configure the external serial source for the Arduino interface described here: five comma-separated integers, a semicolon terminator, and 115200 baud.

The repository starts at the Arduino's `Serial1` input. Check the acquisition output format and adapt it if needed; the kit's acquisition firmware and Bluetooth transmitter configuration are not included in this release.

## Arduino

Install **Arduino UNO R4 Boards**, **Servo**, and **OSC** by CNMAT using the Arduino IDE board/library managers. `WiFiS3` and `WiFiUdp` come with the UNO R4 board package; do not substitute a generic Wi-Fi library intended for a different board.

The board exposes hardware UART through `Serial1` on D0/RX and D1/TX, separately from USB `Serial`; see the [official UNO R4 WiFi cheat sheet](https://docs.arduino.cc/tutorials/uno-r4-wifi/cheat-sheet/).

1. Open `arduino/glove/glove.ino`.
2. Replace the Wi-Fi placeholders and set `outIp` to the receiving computer's LAN IPv4 address. `192.0.2.1` is a documentation placeholder, not a working default destination.
3. Keep `outPort = 7000` unless you also change the Max receiver.
4. Select UNO R4 WiFi and upload.
5. Open the USB serial monitor at 115200 baud to check connection status and the board IP.
6. Configure the external UART source at 115200 baud and send semicolon-terminated frames. The sketch reads `Serial1`, so typing into the USB serial monitor does not supply glove frames.

Connect external transmitter TX to D0/RX and share ground. D1/TX is initialized but the sketch does not write data back to the source. Verify the external module's voltage requirements before wiring it.

Servo signal pins, in input order, are **D6, D5, D4, D3, D2**. Use a power supply appropriate to the actual servo load and share signal ground with the Arduino. Determine acceptable angles for the mechanical assembly before attaching linkages; the supplied 0–180 degree limits are software defaults.

## Max for Live

Keep `max/devices/` intact: the `.amxd` devices need `unitPart.maxpat`, and the regression device reads `gloveRegressor10.json` by filename. Add this directory to Max's File Preferences search path if a helper or model fails to resolve. The extracted patches in `max/source/` contain the same dependencies; add `max/devices/` to the path when editing them.

Install these external packages:

| Package | Needed by | Installation source |
| --- | --- | --- |
| CNMAT MMJ Depot | `Glovebang`: `delta` | [Official repository](https://github.com/CNMAT/CNMAT-MMJ-Depot); install as a Max package following its README. |
| Data Knot | `reressorMapping2`: `dk.regressor`, `dk.regressorcreate~` | Max Package Manager; [project page](https://rodrigoconstanzo.com/data-knot/). |
| FluCoMa / FluidCorpusManipulation | Data Knot regression internals | Max Package Manager; [MLPRegressor reference](https://learn.flucoma.org/reference/mlpregressor/). |

`delta` here is a message-rate abstraction from CNMAT, not the MSP object `delta~` or the Gen operator of the same name. Ensure Max resolves the intended abstraction if you have other libraries with overlapping names.

Place one receiver on a dedicated audio track. Put the direct/regression mapping devices on audio tracks or after instruments. Put `Glovebang` before an instrument on a MIDI track. Direct and regression mapping devices have stereo pass-through; the receiver has no audio pass-through.

For each parameter mapping row, activate its assignment button and select a target parameter in Live. Check the resulting value range and parameter tooltip. Verify assignment persistence by saving and reopening your Live set before relying on it for performance.

## Calibration

The Arduino divides source integers by ten before applying trims/limits. Confirm the source range first: the default firmware expects values up to roughly 1800 for a full 180-degree channel.

The receiver's `p OSCScale` uses minima **0, 18, 18, 18, 70**, with maxima **180**. Record the actual values from the glove in its intended low and high poses, then adjust each channel's scale objects. All channels pass through a 0–1 clip after scaling.

For software-only inspection, values `0,18,18,18,70` represent the lower endpoints and `180,180,180,180,180` the upper endpoints. To produce those endpoints from the external serial source with the default Arduino settings, send:

```text
0,180,180,180,700;
1800,1800,1800,1800,1800;
```

These examples also command the servos. Inspect software with actuators disconnected or linkages removed until the mechanical ranges are established.

Calibrate before using the supplied regression model. Changes to channel order, normalization, or gesture poses change the model's input distribution; capture a new training set if those change materially.

## Training a new mapping

1. Open the regression device in the Max editor and locate `dk.regressorcreate~` and its control messages.
2. Use `clear` if starting a new set of examples.
3. Hold a pose, set the ten target values in the output multislider, and send `addpoint`. The live inference stream also feeds that multislider, so pause incoming glove updates while editing targets to avoid overwriting them.
4. Repeat for a range of poses and targets.
5. Enable `train`, monitor the entry count and loss, and stop training when appropriate for the package settings.
6. Use `write` to export a new JSON. Then explicitly send `read <filename>` to `dk.regressor`; training does not automatically replace the active inference model.
7. Check unseen poses, output saturation, and Live parameter behavior before performance use.

Keep the original model as a reference and update the file-loading message if your new model uses another filename.

## Troubleshooting

| Symptom | Check |
| --- | --- |
| USB monitor shows standalone mode | Check credentials, network availability, and board Wi-Fi firmware. Restart after fixing configuration; the sketch has no explicit reconnection loop. |
| Servos move but Max values stay unchanged | Check destination computer IP, shared LAN, UDP 7000, host firewall, and whether another receiver is using the port. |
| USB serial input does nothing | Glove frames enter through `Serial1` on D0/D1, not USB `Serial`. |
| Receiver moves but mapping is blank | Check `unitPart.maxpat` resolution in Max File Preferences and the Max Console. |
| MIDI detector fails to load | Check CNMAT MMJ Depot and the resolved `delta` abstraction. |
| No regression output | Check Data Knot / FluCoMa installation, the model file search path, and JSON load errors. |
| Several channels seem stuck at zero | Check the per-channel scale minima and whether input values were divided by ten twice. |
| External application finger numbers are reversed | The localhost forwarding branch explicitly maps internal channels 4→0, 3→1, 2→2, 1→3, 0→4. |
| Mapping target is wrong after reopening Live | Reassign the parameter and test saved-set restoration; the helper stores runtime IDs without a canonical-path restore scheme. |
| Notes retrigger too frequently | Check movement threshold, source cadence, and burst chance. The supplied detector has no hysteresis or edge debounce. |
| Audio disappears through the receiver | Move the receiver to a dedicated control track; it has no wired audio pass-through. |
