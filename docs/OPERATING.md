# Operating guide

## 1. Prepare the hardware

Use an Arduino UNO R4 WiFi and two Bluetooth-to-UART receivers paired with their gloves. Connect Left receiver TXD to **D0**, Right receiver TXD to **D12**, and both grounds to Arduino GND. Use the receivers' specified 3.3 V supply. Receiver RXD pins may remain disconnected for receive-only operation; optional return paths are Arduino D1 → Left RXD and D11 → Right RXD with compatible UART voltage levels.

Open `arduino/glove_usb_dual_hardware/glove_usb_dual_hardware.ino` in Arduino IDE. Install the Arduino UNO R4 board package and Servo library, select **Arduino UNO R4 WiFi**, choose its port and upload. The supplied sketch enables the right hardware UART. For data-only operation set `ENABLE_SERVOS=0` before upload. Close Max's USB port before uploading, and close Arduino Serial Monitor afterwards.

The computer connection is USB. The glove-to-receiver links are still Bluetooth; pairing is handled by the glove/receiver kit, not this sketch.

## 2. Install the Max for Live devices

Extract each package. Keep every device's AMXD and its companion JavaScript/HTML files together. Copy the extracted module to your Ableton User Library if desired. Editable MAXPAT sources are included alongside the devices.

Install **FluidCorpusManipulation / FluCoMa** in Max Package Manager to use Gesture or Neural Scope. Their runtime uses native `fluid.mlpclassifier~` and `fluid.mlpregressor~`; it does not need Data Knot. The other three Max devices have no external Max package requirement.

| Device | Placement |
| --- | --- |
| Glove Receiver Dual | Audio track; use one per Set |
| Glove Mapper | Audio track or after a MIDI instrument |
| Glove Gesture | Audio track or after a MIDI instrument |
| Glove Neural Scope | Audio track or after a MIDI instrument |
| Glove MIDI Trigger | MIDI track, **before** an instrument |

The audio effects pass stereo audio through. Shared Max buses carry hand values across tracks, so the MIDI device does not need the Receiver on its own track. Keep Live's audio engine enabled for parameter mapping.

## 3. Connect and calibrate the Receiver

1. Load Glove Receiver Dual. Open **USB…**, click **Refresh**, select the board's actual USB port, then **Open**. Selecting a port alone does not open it. Open also selects USB input.
2. Check that both hands become **LIVE** when data arrive. The USB status identifies L/R activity and displays board/UART diagnostic counters.
3. Open **Left Calibrate**. Hold the hand open for at least 0.3 seconds and click **Open → 0**. Hold a comfortable fist for at least 0.3 seconds and click **Fist → 0.9**. Repeat for Right. Follow the status if a capture is rejected.
4. Confirm that the five values and curl meters follow their fingers. Display order is pinky, ring, middle, index, thumb; the hand drawings are mirrored spatially. The calibration window's Input row shows values before endpoint calibration/filtering.
5. Tune **Smooth** and **Deadband**. Defaults are 8 ms and 0.003. Reduce smoothing for quicker response or increase it for steadier control. Stabilize off bypasses both stages.

Use consistent calibration/filter settings before recording training examples. Save the Live Set to keep complete calibration pairs and settings. USB recalls closed; select/check the board and click Open each time the device is loaded.

For OSC input, choose OSC and send five degree arguments to `/servos` on UDP 7000 for Left and 6000 for Right; normalized input uses `/GLeft` and `/GRight`. Returning to OSC closes USB. For external OSC forwarding, enter IP/host and port, click Apply, then enable OSC Out. This sends `/GLeft` and `/GRight` with five calibrated 0–1 values.

## 4. Map fingers directly

Load Glove Mapper. Click the desired finger's **Map**, then click a Live parameter. **×** releases it. Set Min/Max as percentages of the target range; reversed ranges invert the response. Calibration gives open = 0 and fist = 0.9, leaving extra curl headroom to 1.0.

The Mapper follows Receiver filtering and adds no second smoothing. It keeps its last values in HOLD. Map to suitable exposed device parameters and save the Set to retain assignments.

## 5. Train gesture classification

Load Glove Gesture and choose **Left hand**, **Right hand** or **Both hands**. Select Open, Fist, Index, V, Middle or OK. Both has separate left/right menus; each chosen pair is trained as one combined class.

1. Click **Record 2s** while holding the selected pose. Repeat with natural variations. Recorded classes become enabled; Include in training can exclude a class.
2. Record **Other 2s** examples for relaxed poses and transitions. Every enabled class and Other need at least 20 examples.
3. Click **Train**, then **Run**. The main image shows the detected pose or pair. Confirming waits for the stable-time guard; Confirmed is active; Other is unrecognized.
4. Try new repetitions and transitions. Tune Hold, Gap and Radius if needed. Radius is a distance cutoff, not a probability.
5. Open **Mapping**, choose a class/pair, click Map, then a two-state exposed device parameter. Choose Toggle, Pulse, Hold, On or Off. × clears a target.

Gesture Toggle flips a button once on stable entry; Gesture Hold stays high while the pose is confirmed. These actions are distinct from MIDI Trigger's curl-held Toggle mode. A pose must exit/re-enter for another stable entry trigger. Track arm/mute/transport and arbitrary UI buttons are not targets of this mapping window.

Name and Save a model, select it and Load to recall it, and Export/Import JSON to transfer it. JSON does not include Live button assignments. Save the Live Set for models, banks and mappings. Keep both hands connected when using Both.

## 6. Train continuous neural mapping

Load Glove Neural Scope. **This track** uses its own track; **Selected track** follows Live's selected track. Follow uses the track's selected device; choosing TARGET pins one.

1. Choose Left/Right/Both and select the parameters in **Scope**. Open ↗ for the larger editor. Use a plug-in's Configure control if a required parameter is not exposed to Live.
2. Keep Run off. Make a glove pose, set the target sound and click **Capture**. Start with 8–20 different pose/sound pairs; at least two are required.
3. Click **Train**, then **Run**. RMSE shows training error. Test movements between and beyond captured poses; add examples and retrain as needed.
4. Set custom Min/Max to clamp outputs in each parameter's native units. Smooth controls output smoothing. **Stop** releases parameter control.
5. Enter a model name and Save. Select a saved model and Load, or Export/Import JSON. Input mode and parameter structure must match. Save the Live Set to retain models and banks.

Changing target, input mode or Scope stops active control. Load and Set recall leave Run off. Review the target after replacing/reordering devices. Neural Scope holds each hand's latest valid input; it has no independent per-hand timeout/pair-skew guard. Stop before disconnecting a hand, especially in Both mode.

## 7. Perform MIDI notes

Load Glove MIDI Trigger before a MIDI instrument. Each hand has five independent finger rows.

- **Accel** creates short notes from bend acceleration. Stronger movement increases note-on velocity.
- **Toggle** begins a held note above curl 0.5 and releases below 0.45. Return to neutral before starting or re-enabling a bent finger.
- **Fixed** uses Note. **Random** chooses from Root/Scale within that finger's inclusive Low–High range. An empty range produces no note.
- **V Min / V Max** set each finger's MIDI velocity endpoints; reversed endpoints invert the response.

Click **Calibrate 8 s** and make several representative strikes with enabled fingers. Notes pause during capture. Calibration sets one shared acceleration reference; no sufficient motion keeps the previous value. Click again to cancel. Adjust Sens %, Threshold, Length ms and Retrig ms. Use **Panic** to release generated notes.

Acceleration is calculated from finger curl, not IMU data. A held note's velocity is established at onset; continued curl sends **Poly Aftertouch**. Configure a pressure-sensitive instrument to hear continuous intensity changes. Random pitch remains fixed for the duration of a hold. Assign distinct pitches for independent finger articulation; identical generated pitches share a voice. Avoid overlapping keyboard/glove notes on the same pitch if independent release is needed.

## Troubleshooting

| Symptom | What to check |
| --- | --- |
| No USB port | Board cable/port and OS serial availability; Refresh after connecting the board. |
| Port cannot open | Close Serial Monitor and other programs using the same port. |
| Waiting with no board status | Confirm the selected port, uploaded sketch, USB cable and that Open was pressed. |
| Board status arrives but UART bytes stay zero | Glove power/pairing, receiver power/common GND and TXD wiring: Left D0, Right D12. |
| UART bytes rise but valid-frame counts do not | 115200 8N1, eleven comma-separated integers and semicolon termination. |
| Values assigned to the wrong hand/finger | Receiver labels, D0/D12 wiring and pinky/ring/middle/index/thumb source order. Inspect Calibrate Input before capturing. |
| Calibration rejected | Keep still; ensure both poses span every finger sufficiently and data remain fresh. |
| Excessive delay | Reduce Smooth; inspect receiver/board queues and pairing; use the D12 hardware input. Display refresh does not set mapping speed. |
| MIDI device is silent | MIDI track placement before an instrument, fresh hand data, finger On, neutral re-arm, Threshold/Sens, and a nonempty random scale/range. |
| Held note does not change intensity | The instrument must respond to Poly Aftertouch. |
| FluCoMa object unavailable | Install FluidCorpusManipulation in the Max environment used by Live. |
| Gesture repeatedly shows Other | Record representative examples/Other, verify input mode/calibration, and review Radius. |
| Neural Scope cannot load a model | Match input dimensions and scoped target parameter structure. |

See the [technical specification](TECHNICAL.md) for exact protocols and processing.
