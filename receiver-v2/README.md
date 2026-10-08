# Glove Receiver Dual

A compact, dual-hand Max for Live audio effect based on the original `GloveRecevier` and the **ElastremeSense Manu-5D e-skin data glove kit** project. It preserves the original left-hand calibration, adds a right-hand receiver, adds USB serial input alongside OSC, filters finger jitter, maps ten finger values to Live parameters, and forwards normalized OSC frames.

[Download the receiver and USB firmware](Glove_Receiver_Dual.zip).

## Install

Keep `Glove_Receiver_Dual.amxd`, `glove_dual_engine.js`, `glove_hands.js` and `glove_usb_serial.js` **in the same folder**. Drag the AMXD onto an audio track in Ableton Live. The device passes stereo audio through unchanged. This source release uses companion JavaScript files; do not move only the AMXD. Max 9 / a Live edition supporting Max for Live is the target environment.

The original receiver is retained in `../max/devices/GloveRecevier.amxd`. Remove or disable other receivers that bind UDP 7000 or 6000, and use one Dual receiver per set: the Max buses are intentionally shared.

## USB input

The **Input** menu selects **OSC** or **USB**. OSC is the initial mode. USB uses one Arduino connection carrying both hands at **115200, 8N1**; it does not require Wi-Fi.

1. Upload the [dual USB firmware](../arduino/glove_usb_dual/glove_usb_dual.ino) to UNO R4 WiFi. Left module TXD goes to D0; Right module TXD must go to **D11**, with optional TX back to the module on D10. Supply the provided receivers with 3.3V and match signal levels. See the [wiring guide](../arduino/glove_usb_dual/README_中文.md).
2. Close Arduino Serial Monitor and any other program using the same port. Click **USB…** to open the settings window. Click **Refresh**, select the actual USB port, then **Open**. Open also switches Input to USB. The device displays USB activity as L, R or L / R after valid frames arrive. A port selection alone does not open it.
3. Use **Close** before uploading firmware or giving another program the port. Returning Input to OSC closes USB and re-enables the two OSC paths. Both UDP sockets remain allocated, so another receiver must still avoid binding 7000/6000.

```text
L,180.0,160.0,150.0,149.0,134.5;
R,170.0,152.0,149.4,158.0,132.1;
```

These are five **degree values**, already divided by ten in the firmware; this receiver does not divide them again. L/R routes to the same raw calibration and filtering as /servos. The format requires the hand tag, exactly five finite values from 0 to 180, and a semicolon; CR/LF after the terminator is accepted. Partial, oversized, binary and malformed frames are rejected. On Open the first incomplete fragment is discarded until a delimiter or newline. The firmware status `#ERROR,RIGHT_SERIAL_INIT;` is displayed as a Right initialization error, not parsed as finger values.

Port enumeration, Open/Close and 5ms polling use Max's native `serial` object; no Node process, Python bridge, driver installer or serial package is bundled. A driver may be needed if the operating system does not expose the board's port. The saved Live Set retains **the port name**, not its menu index. Port recall and device load always start closed; click Open after confirming the device. A waiting-data status is not proof of successful Bluetooth pairing or an open physical port.

The compact native main UI stays **808 × 169**, within Live's fixed device height. Input selects OSC or USB; **USB…** opens a separate **580 × 80** native settings window for Port, Refresh, Open, Close and status. See [Cycling ’74's device UI guide](https://docs.cycling74.com/userguide/m4l/live_userinterfaces/). Keep one receiver per Set because the GLeft/GRight buses are shared.

## OSC input and finger order

| Hand | UDP port | Raw OSC address | Normalized OSC address | Max bus / output OSC address |
| --- | ---: | --- | --- | --- |
| Left | 7000 | `/servos` | `/GLeft` | `GLeft` / `/GLeft` |
| Right | 6000 | `/servos` | `/GRight` | `GRight` / `/GRight` |

Each message must contain exactly **five numeric arguments**, in the original project's order: **pinky, ring, middle, index, thumb**. Both receivers reject incomplete or nonnumeric packets. Normalized input is clipped to 0–1 and bypasses calibration; raw input uses:

```text
minimum = [0, 18, 18, 18, 70]
maximum = [180, 180, 180, 180, 180]
value[i] = clamp((raw[i] - minimum[i]) / (maximum[i] - minimum[i]), 0, 1)
```

The right hand initially uses the same calibration. Verify its physical sensor order and ranges. The supplied Arduino sender targets 7000; configure a second sender to target **6000** for the right hand. This device does not add acquisition firmware for the kit.

## Mapping and interface

The device uses native `live.numbox`, `live.text` and `live.comment` controls. Two mirrored vector hand outlines sit below the finger displays. Each display shows its filtered value from **0.000 to 1.000**. The small finger strokes brighten with movement. Each finger has an embedded, compact version of Cycling '74's installed `liveui.map` module.

Click **Map**, then click a mappable Live parameter. The button shows an abbreviated target name. Click **×** to release that mapping. Ten `live.remote~ @normalized 1` objects apply the finger values to each target's complete native range; they require Live's audio engine to run. The standard mapping module retains its `_persistence` configuration. Host reload, parameter reassignment, duplicate-device and mapping-persistence behavior must be checked in Live before performance use.

The displays are read-only monitors rather than exposed automation parameters. For a software test, send normalized `/GLeft` or `/GRight` packets to the corresponding input port.

**WAIT** means no data has arrived; **LIVE** means valid incoming data; **HOLD** means no valid packet for one second. During HOLD, the last value remains active and any in-progress smoothing finishes. HOLD does not unmap parameters.

## Jitter suppression

**Stabilize** enables two independent stages for every finger:

1. **Deadband**: ignore changes smaller than the threshold relative to the last accepted input. Default **0.003** on the 0–1 scale. Larger movement accumulates until it exceeds the threshold; it is not compared against the moving filter output.
2. **Smooth**: a time-aware exponential filter, default **30 ms**, evaluated by a nominal 10 ms Max Task. `alpha = 1 - exp(-elapsed_ms / Smooth_ms)`. After one time constant, a step reaches approximately 63%; after three, approximately 95%. Scheduler delay is accounted for, but real-time delivery depends on Max/Live load.

The first valid frame initializes immediately. Smooth = 0 bypasses time smoothing while retaining deadband. Stabilize off bypasses both stages. Deadband = 0 accepts every change. Recommended tuning: increase the deadband when single raw servo steps remain visible; increase smoothing for steadier control, or reduce it for a faster response.

The filtered frame is the single source for the display, native parameter mappings, `send GLeft` / `send GRight`, and OSC forwarding. Every frame has five values from the same processing tick. UI and OSC outputs remain change-driven. The GLeft/GRight buses also deliver the filtered frame whenever new valid physical data arrives, even if the pose is stationary. Both buses are emitted from the same filter tick when both hands have pending input. This keeps regression/classification consumers fresh while holding a pose; no new input means no synthetic bus heartbeat. Multiple input frames arriving within one tick coalesce to the latest state. Pending frames older than 100ms at the filter tick do not refresh consumers. A one-off software packet is therefore suitable for display testing, but sustained training/Run needs a real stream.

## OSC forwarding

Enter the destination **IP** or host name, set **Port** (default 8000), and click **Apply**. Pressing Return in the IP field also applies it. Enable **OSC Out** to forward one five-argument OSC message per changed hand:

```text
/GLeft  0.1 0.2 0.3 0.4 0.5
/GRight 0.5 0.4 0.3 0.2 0.1
```

Max's `udpsend` encodes these as OSC rather than plain text. OSC forwarding is off initially; enabling it or applying a destination re-sends any current hand frames. IP uses bound `pattr` state, and the port and filter settings use native Live parameter state. Keep the destination separate from the device's own input ports to avoid an OSC feedback loop.

Official object references: [live.map](https://docs.cycling74.com/reference/live.map/), [live.remote~](https://docs.cycling74.com/reference/live.remote~/), [udpreceive](https://docs.cycling74.com/reference/udpreceive/), [udpsend](https://docs.cycling74.com/reference/udpsend/), [serial](https://docs.cycling74.com/reference/serial/), and [live.numbox](https://docs.cycling74.com/reference/live.numbox/).

## Source and rebuild

`Glove_Receiver_Dual.maxpat` is the editable source. The AMXD contains the same patcher payload. Mapping subpatchers are embedded, so no separate `unitPart`, CNMAT decoder, or additional mapping abstraction is required.

```sh
python3 tools/build.py
node tools/test_engine.js
node tools/test_usb.js
python3 tools/test_patch.py
```

The builder uses the official `liveui.map.maxpat` from a locally installed Max for Live package. The hand drawing is original vector JavaScript, not an external image. See `VALIDATION.md` for the actual verification performed and host limitations.

## Layout previews

Illustrative layout previews generated from the shipped vectors and presentation rectangles; these are not Live screenshots.

![Main receiver](layout-preview.png)

![USB settings window](usb-settings-preview.png)
