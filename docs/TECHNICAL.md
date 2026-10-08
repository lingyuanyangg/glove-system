# Technical specification

This specification describes the supplied Arduino sketch, four Max for Live patch payloads, and regression JSON inspected on **2026-10-06**. Statements about wiring and algorithms follow the files; end-to-end performance has not been measured.

The rebuilt dual-hand receiver is described separately in the [Receiver v2 specification and guide](../receiver-v2/README.md), including exclusive OSC/USB input selection, a native USB serial adapter for tagged L/R degree frames, right-hand UDP input, ten normalized native mappings, deadband/time filtering, atomic Max frames and configurable OSC forwarding.

## Glove hardware platform

The glove hardware in this project is based on the **ElastremeSense Manu-5D e-skin data glove kit**, as identified by the project owner. The kit forms the glove sensing side of the system; the published software implements the downstream Arduino servo/OSC bridge and Max for Live processing.

The external acquisition and transmission setup must present five integer values to the Arduino in the serial format specified below. This format is the interface required by the supplied sketch; it is not a claim about the kit's unmodified factory protocol. Kit acquisition firmware, transmitter configuration, sensor wiring, and product specifications are outside the supplied files.

## 1. Arduino bridge

The UNO R4 WiFi sketch is a serial-to-servo and serial-to-OSC bridge. It does not sample glove sensors directly. `Serial` provides USB diagnostics at 115200 baud; `Serial1` receives external data at 115200 baud on D0/RX and D1/TX. The external Bluetooth hardware and its pairing protocol are not specified in the provided files.

### Serial framing and conversion

The expected input is an ASCII sequence of five decimal integers separated by commas and terminated with a semicolon:

```text
900,900,900,900,900;
```

The receive buffer is 160 bytes, allowing up to 159 stored characters plus the terminating null. Each `;` calls `handleFrame()`. Leading and trailing whitespace is removed, then `strtok()` and `strtol()` parse up to five fields.

For each channel `i`:

```text
ri = round(vi / 10), with half values rounded away from zero
si = clamp(ri + SERVOi_TRIM, SERVOi_MIN, SERVOi_MAX)
```

The defaults are trim = 0 and limits = 0–180 for all channels. Thus 900 produces 90, 1800 produces 180, and negative values clamp to zero under the default limits.

| Input index | Servo | Signal pin | Physical command | OSC argument |
| ---: | --- | --- | --- | --- |
| 0 | `servo1` | D6 | `180 - s1` | `s1` |
| 1 | `servo2` | D5 | `180 - s2` | `s2` |
| 2 | `servo3` | D4 | `180 - s3` | `s3` |
| 3 | `servo4` | D3 | `180 - s4` | `s4` |
| 4 | `servo5` | D2 | `s5` | `s5` |

The OSC values describe the calibrated channels **before** physical direction reversal. For example, an OSC value of 30 commands 150 degrees on one of the first four servos, and 30 degrees on the fifth. Calibration limits act before this reversal, so physical limits for the first four servos are `[180 - MAX, 180 - MIN]`.

### Startup and network behavior

`setup()` starts both serial ports and attempts Wi-Fi connection. The explicit polling loop checks at most 20 times with a 500 ms delay. This is approximately a ten-second polling window; it does not bound every internal library call.

On successful connection, the code sets `isWifiConnected = true` and binds the local UDP socket to port **2390**. It then attaches each servo and writes `clamp(90 + TRIM, MIN, MAX)`. This initial write does not use the later first-four-servo reversal. A 90-degree command is an initialization value, not a guarantee of mechanical safety for every assembly.

For every processed nonempty frame, servo commands are written first. If the startup connection succeeded and `WiFi.status()` is currently `WL_CONNECTED`, one OSC message is sent:

```text
Address: /servos
Arguments: s1 s2 s3 s4 s5
OSC argument types: five int32 values (iiiii)
Destination: configured computer IPv4 address, UDP 7000
```

This is one OSC message with five arguments, not a plain text list and not an OSC bundle. The transmit frequency follows incoming frames; there is no fixed network update rate. The source binds port 2390 but contains no UDP receive or feedback-control path. If startup Wi-Fi fails, servo processing continues and this sketch never retries `WiFi.begin()`.

### Parser limitations

- Missing trailing fields remain zero. Empty CSV fields are skipped by `strtok()`, which can shift later values into earlier channels.
- `strtol()` is used without end-pointer or overflow checks, so malformed numeric fields can become zero or partially parsed integers.
- Extra fields after the first five are ignored.
- Buffer overflow resets `inLen`; it does not discard the complete remaining frame up to the next semicolon. A frame suffix can consequently be parsed as a new frame.
- No input timeout parks the servos when serial data stops; they retain their most recent commands.

These behaviors are preserved in the public firmware copy.

## 2. OSC receiver and normalization

`GloveRecevier.amxd` contains the following receive path:

```text
udpreceive 7000 → route /servos → multislider (5, 0–200)
    → unpack f f f f f → p OSCScale → join 5 → s GLeft
```

Max's `udpreceive` decodes OSC into Max messages in its default mode, so a separate decoder is not present or required by this patch. See [Cycling '74's reference](https://docs.cycling74.com/reference/udpreceive/).

The `p OSCScale` subpatch applies channel-specific linear scaling followed by `clip 0. 1.`:

| Channel | Input minimum | Input maximum | Normalized value |
| ---: | ---: | ---: | --- |
| 0 | 0 | 180 | `clip(s1 / 180, 0, 1)` |
| 1 | 18 | 180 | `clip((s2 - 18) / 162, 0, 1)` |
| 2 | 18 | 180 | `clip((s3 - 18) / 162, 0, 1)` |
| 3 | 18 | 180 | `clip((s4 - 18) / 162, 0, 1)` |
| 4 | 70 | 180 | `clip((s5 - 70) / 110, 0, 1)` |

These values are installation-specific calibration constants. The internal five-value list preserves channel order; the receive/UI path processes floats after the Arduino's integer output.

### Optional OSC forwarding

Each normalized value also passes through a `prepend /glove/finger/N` object into `udpsend 127.0.0.1 8000`. Max encodes these messages as OSC; see the [UDP send reference](https://docs.cycling74.com/reference/udpsend/).

The forwarding wires reverse channel numbering:

| Internal `GLeft` index | Forwarded address | Label in `Glovebang` |
| ---: | --- | --- |
| 0 | `/glove/finger/4` | pinky |
| 1 | `/glove/finger/3` | ring |
| 2 | `/glove/finger/2` | middle |
| 3 | `/glove/finger/1` | index |
| 4 | `/glove/finger/0` | thumb |

Finger names come from the MIDI patch labels, not from the Arduino sender. Verify the physical glove wiring before relying on that naming convention. The five outgoing messages are independent UDP packets without a shared frame identifier or bundle timestamp.

The receiver has an audio-effect file header but no `plugin~ → plugout~` audio path. Its function is control reception. The shared `GLeft` bus has no instance-specific prefix.

## 3. Direct Live parameter mapping

`Glove_Direct_Map.amxd` receives `GLeft`, unpacks its five floats, and feeds five `unitPart.maxpat` bpatchers. It also connects the two `plugin~` outputs directly to the corresponding `plugout~` inputs.

The recovered `unitPart.maxpat` implements assignment through:

```text
Assignment control → live.path live_set view selected_parameter
    → parameter ID → live.object
Incoming normalized value → scale 0. 1. [target min] [target max]
    → output slider → set value $1 → live.object
```

Its `p param_path` queries the selected parameter's `min`, `max`, `name`, and parent objects. Min/max update the scaling bounds and output slider. The parent names form a descriptive tooltip. A range control allows the output slider bounds to be adjusted.

The assignment LED, gate, and 500 ms metro implement an assignment selection/blinking interaction. Once assigned, each row writes the target parameter's `value` using `live.object`; this is direct Live API control, not MIDI CC or `live.remote~` modulation.

The helper stores parameter IDs in Live-enabled number boxes, but it does not contain a persistent canonical-path restoration scheme. Assignment survival after set reload, copied tracks, or device reordering requires host testing. The original helper also retains an old Reaktor parameter tooltip; it is not a runtime Reaktor dependency.

## 4. Gesture-triggered MIDI

`Glovebang.amxd` is a MIDI-effect device. Its five channels follow the labels pinky, ring, middle, index, thumb and use the normalized `GLeft` values.

### Movement detection

Each detector sends current values into the left inlet of the **CNMAT MMJ Depot `delta` abstraction**. A `zl.reg` stores the current value, while `metro 10 @active` periodically sends the stored reference into the right inlet of `delta`. The locally inspected abstraction subtracts the reference from the new value, then updates its internal reference.

The result is compared with `> 0.2`, and `sel 1` generates a bang for positive changes above the threshold. A shared flonum can override this threshold through the detectors' second inlets. The metro interval is nominally 10 ms; actual scheduling and source cadence affect the comparison.

This detector is one-sided, with no absolute-value operation, hysteresis, or dedicated edge debounce. `sel 1` responds whenever it receives 1, so repeated qualifying updates can retrigger it. It is a movement trigger, not a trained gesture classifier.

### Note generation and bursts

Each trigger runs `t b b b b` to update optional random pitch and duration, issue the main note, and test a burst generator. Pitch and duration randomization are gated by separate toggles. The pitch branch uses `random 127` plus configurable `scale 0 127 0 127` bounds. The duration branch uses `random 1000`; number boxes feed duration and velocity into `makenote 100 100`. Load messages initialize duration and velocity to 100 and the upper pitch limit to 127.

Each channel sends `makenote` pitch/velocity output to its own `noteout`, including the scheduled zero-velocity release. No explicit MIDI channel override is wired into these `noteout` objects.

The burst subpatch compares `random 100` with the shared `chance` dial. When selected, it starts `qmetro 10` with an interval from `random 50` and stops it using a delay computed as:

```text
random 1. → pow(value, 2) → scale 0. 1. 0. 500. → delay
```

Under the saved Max 9 behavior, `random 1.` produces floats in its range; this yields a variable burst window up to roughly 500 ms. Each burst tick bangs the channel's existing pitch number box. It does not itself refresh the random pitch/duration branches. Integer random intervals can include zero; practical timing must be checked in the host. See the [Max random reference](https://docs.cycling74.com/reference/random/) for float arguments.

## 5. Five-to-ten regression mapping

The inference path in `reressorMapping2.amxd` is:

```text
r GLeft → dk.regressor @outputmode rawlist
    → multislider (10, 0–1) → unpack 10 floats → ten unitPart rows
```

The original patch retains `loadbang → button → read gloveRegressor10.json`. That default model has been removed at the project owner's request; this is a historical message, not a shipped model dependency. Load your own Data Knot model or use the new [Glove Neural Scope](../neural-scope/README.md) saved-model selector. Data Knot provides the regression abstractions and uses FluCoMa's `fluid.mlpregressor~` internally. Its `rawlist` output mode returns values without parameter-name/value pairs. See [Data Knot](https://rodrigoconstanzo.com/data-knot/) and the [FluCoMa MLPRegressor overview](https://learn.flucoma.org/reference/mlpregressor/).

The removed model was inspected before removal and contained:

| Property | Stored value |
| --- | --- |
| Training examples | 10 paired rows, keys `0`–`9` |
| Input dimensions | 5 |
| Output dimensions | 10 |
| Network structure | 5 → 3 → 3 → 10 |
| Hidden layer activations | Code `3`, tanh in the locally installed package documentation |
| Output activation | Code `0`, identity |
| Output names | `parameter1`–`parameter10` |
| Metadata scaler | `none` |
| Metadata Python-trained flag | `0` |
| Stored creation string | `2026-07-06 / 18:53:43` |

The linear output layer can predict values outside 0–1. The device's output multislider constrains the values passed to the ten mapping rows. The removed JSON also contained an `input_normalization` object with `cols = 10`; this does not replace the verified five-column input dataset or the five-row first-layer matrix. It should be interpreted through the package that reads the model, rather than guessed as an additional preprocessing step.

### Training controls

`GLeft` also feeds the first inlet of `dk.regressorcreate~`; the ten-value output multislider feeds its second inlet as target parameters. The editor exposes `addpoint`, `clear`, `train $1`, `print`, and `write`. Entry count and training loss are displayed, with loss also sent to a graph.

Training and inference are separate objects. There is no direct connection that replaces the inference model when training finishes. Export the new JSON and explicitly reload it into `dk.regressor`.

An editor-only branch uses `uzi 10 → random 2. → - 1. → zl.group 10` to create target lists. No initiating trigger is wired to `uzi` in the supplied patch. This branch produces values nominally between -1 and 1 before the 0–1 multislider; it is not an automatic training data generator.

This is supervised continuous regression over example poses and control values. The historical ten examples and stored fit did not establish prediction accuracy, generalization, or suitability for another user's calibration. No evaluation dataset or benchmark is provided.
