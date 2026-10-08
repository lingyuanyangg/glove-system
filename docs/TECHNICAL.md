# Technical specification

## Hardware and transport

The source is the **ElastremeSense Manu-5D e-skin data glove kit**. Each glove communicates with its paired Bluetooth-to-UART receiver. The Arduino bridges the two UART streams to USB; it does not acquire sensor signals directly or perform Bluetooth pairing.

| Connection | Arduino pin / interface |
| --- | --- |
| Left receiver TXD → board RX | D0, `Serial1` |
| Optional board TX → left receiver RXD | D1 |
| Right receiver TXD → board RX | D12, dedicated SCI0 hardware UART |
| Optional board TX → right receiver RXD | D11 |
| Computer | USB connector; `Serial` via the board's ESP32 USB bridge |
| Both UART inputs / USB | 115200 baud, 8 data bits, no parity, 1 stop bit |

The supplied receivers use 3.3 V power and common ground. UNO R4 WiFi transmit GPIO levels are 5 V; optional connections into a module's RXD need compatible levels. For receive-only use, leave both module RXD pins disconnected. Match the module's TXD levels to the board's input requirements.

`RIGHT_USE_HARDWARE_UART` is enabled in the supplied sketch. `ENABLE_SERVOS=1` enables five servos on pins 6, 5, 4, 3 and 2; `SERVO_HAND=0` selects Left and `1` selects Right. The first four servo directions are reversed and the thumb is direct. Set `ENABLE_SERVOS=0` for data-only use. Servo power and mechanical arrangements are separate from UART reception.

### Receiver → Arduino

Each UART frame has exactly eleven comma-separated integers and ends with a semicolon:

```text
1800,1600,1500,1490,1345,0,0,0,0,0,0;
```

The first five fields are angles in tenths of a degree, constrained to 0–1800. Their order is **pinky, ring, middle, index, thumb**. The remaining six fields are validated as integers and ignored. Each hand has independent parser state. Incomplete, malformed, overflowing and non-ASCII frames are discarded without replacing a valid pose. The wire format has no checksum, so valid-looking corrupted data cannot be identified by syntax alone.

### Arduino → Receiver

USB frames contain a hand label followed by five degree values:

```text
L,180.0,160.0,150.0,149.0,134.5;
R,170.0,152.0,149.4,158.0,132.1;
```

A newline follows the semicolon. The Arduino divides angles by ten once; Max does not divide USB values again. Input work alternates between hands in bounded 32-byte slices. Complete bursts coalesce to the latest pose. Output is limited to **50 fresh frames per second per hand**, and pending frames older than 100 ms are discarded. No new input means no repeated pose frame. Short bulk USB-bridge UART writes wait for transmission with interrupts enabled.

The board also sends diagnostics once per second:

```text
#STATUS,USB3,L,<bytes>,<valid>,<bad>,<queue_peak>,R,<bytes>,<valid>,<bad>,<queue_peak>;
#ERROR,RIGHT_SERIAL_INIT;
```

Counters are cumulative since boot; queue peak is the largest observed queue, not a dropped-byte count. Diagnostics do not update finger data or train models. Right UART initialization failure lights the onboard LED; it is not a Bluetooth pairing indicator. Servos retain their last position if input stops.

## Receiver processing

Glove Receiver Dual is an audio effect with stereo pass-through. USB and OSC are selectable inputs. Native `serial` polling is nominally 2 ms; filtering runs on a nominal 5 ms task, while numeric/hand monitors refresh at approximately 30 Hz.

| Hand | OSC UDP port | Raw address / units | Normalized address |
| --- | ---: | --- | --- |
| Left | 7000 | `/servos`, five angles in degrees | `/GLeft`, five 0–1 values |
| Right | 6000 | `/servos`, five angles in degrees | `/GRight`, five 0–1 values |

Every hand packet requires exactly five finite numeric values in the common finger order. USB accepts raw degree values in 0–180. OSC normalized values are clipped to 0–1.

### Calibration

Each hand stores five independent Open/Fist endpoint pairs and their input format. Calibrated output is:

```text
curl[i] = clamp(0.9 * (input[i] - open[i]) / (fist[i] - open[i]), 0, 1)
```

Open maps to 0 and the captured fist to 0.9; further sensor travel can reach 1.0. Either sensor direction is supported. Raw endpoints are applied only to raw data and normalized endpoints only to normalized data. Capture averages the last 250 ms of unfiltered input, requires at least three frames with the latest no older than 150 ms, and rejects moving poses. Maximum accepted spread is 3 degrees or 0.02 normalized units. Minimum absolute endpoint span is 5 degrees or 0.025 normalized units for every finger. A failed capture preserves the complete active calibration.

Without a matching endpoint pair, raw values use:

```text
minimum = [0, 18, 18, 18, 70]
maximum = [180, 180, 180, 180, 180]
curl[i] = clamp((raw[i] - minimum[i]) / (maximum[i] - minimum[i]), 0, 1)
```

Normalized input without a matching pair is clipped directly. Completed endpoint pairs are saved with the Live Set; temporary captures and input history are not saved.

### Filtering and outputs

Stabilize combines an input deadband, default **0.003**, and exponential smoothing, default **8 ms**. The deadband compares with the last accepted input. Smoothing uses `alpha = 1 - exp(-elapsed_ms / Smooth_ms)`; the first valid frame initializes immediately. Smooth 0 bypasses time smoothing, Deadband 0 accepts every change, and Stabilize off bypasses both stages.

| Max bus | Content and timing |
| --- | --- |
| `GLeft`, `GRight` | Five calibrated, filtered floats in 0–1 when new physical input is pending; stationary real frames are also published. No synthetic freshness heartbeat. |
| `GLeftControl`, `GRightControl` | Change-driven filtered controls, including smoothing ticks between physical frames; used by Mapper. |
| `GGestureLeft`, `GGestureRight`, `GGestureBoth` | Gesture `enter <label> <number>` and `exit <label> <number>` events. |

Physical frames within one filter tick coalesce to the newest pose. Pending frames older than 100 ms do not refresh consumers. Receiver WAIT means no data since initialization, LIVE means recent valid input, and HOLD means one second without valid input; Receiver and Mapper retain their last values in HOLD. These are arrival states at Max, not Bluetooth sensor timestamps. Use one Receiver per Set because these buses and the two OSC input ports are shared.

OSC Out sends changed five-value `/GLeft` and `/GRight` packets to a configurable destination IP/host and port, default `127.0.0.1:8000`. Apply or enabling output re-sends available current poses. USB port state is recalled closed; the port name, filter settings, destination and complete calibration are retained with the Set.

## Glove Mapper

Ten independent native `liveui.map` components bind fingers to Live parameters through `live.remote~`. Target ranges are queried before applying control. Min/Max are percentages of each target's full native range:

```text
target_fraction = Min / 100 + curl * (Max - Min) / 100
target_value = target_min + target_fraction * (target_max - target_min)
```

Reversed or equal endpoints are valid. With Min 20%, Max 80%, curl 0.9 produces 74% of the target range. Mapper adds no second smoothing stage. Mappings and endpoints are saved with the Set; × releases a target. Live's audio engine must run for signal-based remote control.

## Glove Gesture

Native FluCoMa `fluid.mlpclassifier~` learns five-input single-hand poses or ten-input combined poses. Both concatenates Left then Right and recognizes one complete ordered pair. Supported labels are Open, Fist, Index, V, Middle and OK, plus Other. Both supports **36 ordered combinations**; only enabled recorded classes are trained.

Networks are **5 → 8 → classes** or **10 → 32 → classes**, with tanh hidden activation, sigmoid classifier output, SGD learning rate 0.01, momentum 0.9 and batch size 4. Each enabled class and Other need at least 20 examples. Limits are 400 examples per class and 8,000 total examples for Both.

Each frame expires after 300 ms; Both requires hand arrival times within 80 ms. The stable-time guard defaults to 120 ms and trigger gap to 350 ms. Radius, default 0.18, rejects inputs whose RMS normalized distance to the predicted class's nearest stored example is too large. Radius is a distance test, not a confidence probability. Training error does not measure recognition accuracy on new movements.

A separate Mapping window has six Left, six Right and 36 Both slots. Targets must be exposed two-state device parameters; non-quantized 0–1 switches are accepted. Actions are Toggle, Pulse, Hold, On and Off. Pulse defaults to 120 ms; Pulse/Hold release to the target's low value. Track/transport controls and arbitrary UI buttons are outside this parameter-mapping interface.

Single-hand event numbers are Open 1, Fist 2, Index 3, V 4, Middle 5, OK 6. Both labels use `left__right`; number = `1 + leftIndex * 6 + rightIndex`, with zero-based indices in that order. `fist__v` is 10. Other produces no entry trigger. Stop/input loss exits an active class. Saved model JSON carries examples, labels and weights, without Live target assignments. Finger-bend data alone cannot resolve contact, orientation or position if measured patterns are identical.

## Glove Neural Scope

Native `fluid.mlpregressor~` learns **5 or 10 → 16 tanh units → N linear outputs**, where N is the selected parameter count, up to 256. Separate native training/inference objects and paired datasets hold the model and captured glove/sound examples. Training uses SGD, learning rate 0.01, momentum 0.9, batch size 1 and scheduled fit chunks. Epochs defaults to 800. There must be at least two distinct examples; each bank holds up to 512. Displayed RMSE is training error.

This track selects the effect's own track; Selected track uses Live's selected track. Follow tracks its selected device; TARGET pins a device. Device On is initially excluded from Scope. Each target, input mode and scoped-output structure has an independent bank. Adding/removing examples invalidates its trained model. Changing target/input/scope stops active control.

Glove frames trigger native `predictpoint`. One request is in flight; bursts coalesce to the latest pending frame. Both uses the latest valid value from each hand, with no per-hand expiry or pair-skew test in this device. Stop before disconnecting a source; it is not an independent connection monitor. Predicted outputs are clipped to 0–1, converted to native target ranges, clamped to custom Min/Max and quantized when required. Min/Max clamp learned outputs; they do not rescale the model. Native `live.remote~` output smoothing defaults to 30 ms, adjustable 0–500 ms. Stop releases the mappings.

Up to 128 named snapshots can store weights, examples, scoped outputs and bounds. Load requires matching input mode and target structure and leaves Run off. Export/Import transfers JSON. Raw FluCoMa models bind in scoped table order with matching dimensions; a five-input/ten-output Data Knot regression JSON requires one hand and ten scoped outputs. No preset model is loaded automatically. Banks, snapshots and settings are saved with the Live Set; runtime Live IDs and transient input frames are not model identities.

## Glove MIDI Trigger

This is a MIDI effect placed before an instrument. Each finger selects Accel or Toggle, Fixed or Random, Root/Scale, inclusive Low/High note limits, and velocity endpoints 1–127. Scale choices are chromatic, major, natural minor, Dorian, Phrygian, Lydian, Mixolydian, Locrian, major/minor pentatonic, blues and whole tone. MIDI note limits are 0–127. An empty scale/range intersection emits no note.

Accel measures **bend acceleration**, not IMU acceleration: the magnitude of the second time derivative of normalized curl, in curl/s². Frame intervals below 5 ms coalesce; gaps above 100 ms reset derivatives. Velocity and acceleration smoothing constants are 20 and 30 ms. A 15 ms peak window captures initial trigger strength, serviced by a nominal 5 ms task.

```text
strength = abs(bend_acceleration) / calibration_reference * Sens / 100
velocity_fraction = clamp((strength - Threshold) / (1 - Threshold), 0, 1)
velocity = round(V_Min + velocity_fraction * (V_Max - V_Min))
```

Threshold defaults to 0.25, Sens to 100%, Length to 120 ms and Retrig to 120 ms. Accel re-arms below half Threshold. Eight-second global calibration pools enabled fingers from both hands; it uses the 95th percentile of 120 ms motion-peak bins above 0.5 curl/s² and needs eight bins. Capture suppresses notes. Cancelled/insufficient capture retains the saved reference.

Toggle holds a note above curl 0.5 and releases below 0.45. Curl 0.5–1 maps to V Min–V Max. Note-on velocity is set at onset; continued bending sends per-note Poly Aftertouch at most every 25 ms when its value changes. The instrument must respond to poly pressure for continuous intensity changes. Random pitch is chosen once per onset and held until release. Reversed velocity endpoints are supported.

Fingers sharing a pitch/channel share one generated voice: the first onset supplies note-on velocity, maximum current owner intensity supplies pressure, and the final owner releases it. A 100 ms inter-frame gap resets/releases on the next frame, and 250 ms without valid input releases the hand's notes. Mode/settings changes, disable, Panic, calibration and deletion release generated notes. Toggle requires neutral below 0.45 after load/re-enable/reconnect. Keyboard/clip MIDI passes through as complete reconstructed packets. Incoming and generated notes on the same pitch can still interact at the target instrument.

## Reference documentation

- [Arduino UNO R4 WiFi](https://docs.arduino.cc/hardware/uno-r4-wifi/)
- [FluCoMa MLPRegressor](https://learn.flucoma.org/reference/mlpregressor/) and [MLPClassifier](https://learn.flucoma.org/reference/mlpclassifier/)
- [Live remote control](https://docs.cycling74.com/reference/live.remote~/), [DeviceParameter](https://docs.cycling74.com/apiref/lom/deviceparameter/), and [MIDI](https://docs.cycling74.com/userguide/midi/)
