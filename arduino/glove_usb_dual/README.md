# Dual glove USB firmware

Optional firmware for Arduino UNO R4 WiFi and two Manu-5D UART Bluetooth receivers. It replaces the Arduino-to-computer Wi-Fi hop with one USB serial connection; the glove-to-receiver Bluetooth links remain. It uses the board core's SoftwareSerial and Servo library, with no Wi-Fi or OSC dependencies.

## Wiring

Left receiver TXD → D0 (Serial1 RX); optional receiver RXD ← D1. Right receiver TXD → **D11** (software RX); optional RXD ← **D10** (software TX). `SoftwareSerial rightGlove(11,10)` uses RX first. D10 lacks the required RX interrupt on UNO R4 WiFi with Arduino core 1.6.0; do not use the reversed D10-RX wiring.

The supplied receivers require **3.3V power**, common ground and compatible signal levels. UNO R4 WiFi TX signals are 5V; use appropriate UART level conversion before connecting to a module RX that is not 5V tolerant. For data-only reception the module RX can remain disconnected. Receivers must already be paired with their respective gloves; this firmware does not scan or pair Bluetooth devices.

## Operation

Upload `glove_usb_dual.ino` with UNO R4 WiFi selected. Default five-servo output preserves the original left-hand pins/directions; set `ENABLE_SERVOS=0` for data-only use, or `SERVO_HAND=1` to drive those five servos from Right. This does not drive ten servos.

Input is 115200, 8N1: exactly 11 comma-separated integers terminated by `;`. The first five are angles in tenths of a degree (0–1800); the remaining six are validated and ignored. USB outputs five degree values with one decimal place and a hand label:

```text
L,180.0,160.0,150.0,149.0,134.5;
R,170.0,152.0,149.4,158.0,132.1;
```

Each USB frame ends with a semicolon and newline. Incoming frames are validated atomically; malformed or overflowing frames are discarded. The two receivers have independent buffers. USB output is limited to 50 fresh frames/second per hand and drops pending frames older than 100ms. On UNO R4 WiFi, Serial is the UART feeding the ESP32 USB bridge: the core inherits a zero-returning availableForWrite(), so transmission uses a short bulk UART write instead of a buffer-space gate. These writes wait for UART transmission (approximately 3.5ms for a maximum 40-byte hand frame at 115200), with interrupts active. This is not a fully nonblocking sender. Native CDC builds still use their transmit-buffer-space check. No new input means no repeated stale output. Servos retain their last position on source loss.

Close Arduino Serial Monitor, load the updated [Glove Receiver Dual](../../receiver-v2/README.md), open USB… settings, click Refresh, choose the board's USB port, then Open. Its serial adapter handles L/R routing, calibration, jitter filtering and GLeft/GRight buses. Returning to OSC or pressing Close releases the port; Set recall starts closed. Keep the receiver's three JS companions with its AMXD.

Right software-serial initialization failure lights the onboard LED and reports `#ERROR,RIGHT_SERIAL_INIT;` without stopping Left. The LED is not a Bluetooth pairing indicator.

Both right-input configurations compile on UNO R4 WiFi, and 41 simulated sketch checks pass (29 protocol/queue/interrupt checks, eight bridge checks and four hardware-option checks); see [VALIDATION.md](VALIDATION.md). Physical simultaneous UART timing, pairing, USB, servos and Max/Live integration still require hardware testing. [Chinese instructions](README_中文.md).

## 2026-10-08 transmission fix and diagnostics

Re-upload this corrected firmware if an earlier USB release produced no bytes. The earlier availableForWrite() gate prevented all output on UNO R4 WiFi core 1.6.0; compiling the sketch alone did not expose the issue.

Every second the board now sends `#STATUS,USB3,L,<bytes>,<valid>,<bad>,<queue peak>,R,<bytes>,<valid>,<bad>,<queue peak>;` even without glove data. These are diagnostic counters, never finger values. The updated receiver shows them while waiting: zero UART bytes points to the glove/receiver/pin/power link; increasing UART bytes with no valid frames points to baud/framing. Valid L/R frames still follow the original format. No new hand data means no fabricated hand heartbeat.


## Right-hand queue handling and hardware UART option

The default `RIGHT_USE_HARDWARE_UART=0` retains D11 RX / D10 TX. Before USB transmission, the loop drains the queues present at entry, bounded by their ring capacities and interleaved in 32-byte slices. It retains the newest complete frame from each burst instead of transmitting after just 64 bytes. The drain is bounded even for a continuous source; this is not an end-to-end latency measurement or a guarantee of loss-free input.

SoftwareSerial in core 1.6.0 uses a shared ring-size counter updated in DMA RX and foreground reads. A short interrupt-preserving critical section protects only the right byte read, with the prior PRIMASK restored. Parsing, servo updates and USB writes run outside it. The core's stop-bit/parity error path does not reject all erroneous received bytes, and the wire protocol has no checksum, so legal-looking corrupted values can remain undetected.

For an input path that avoids SoftwareSerial's timer/DMA sampling and ring implementation, set **`RIGHT_USE_HARDWARE_UART` to 1**. **Before uploading**, move Right module TXD to **D12** (hardware RX); optional module RXD goes to **D11** (hardware TX, use compatible levels). Left stays on D0/D1. The code constructs a separate SCI0 UART on D11 TX / D12 RX; it does not repurpose the ESP32 bridge UART or Serial1. Do not upload this mode while module TXD is still connected to D11. Keep mode 0 to use the original wiring.

The USB3 status packet reports cumulative bytes, accepted frames, rejected frames and the peak queue size observed since boot. The receiver shows UART bad / queue peak alongside live activity. A software queue peak near 1023 suggests it approached capacity; it is not a count of dropped bytes. Native-buffer overrun and valid-looking corruption are not fully observable through these counters. USB2 receivers can still use L/R frames but do not display these new diagnostics.

Use the receiver's Calibrate **Input** row to inspect actual degree values before normalization. In particular, 103 degrees produces 0.3 with the old thumb fallback. Verify finger/channel correspondence and raw motion before capturing calibration. The kit also has a separate acquisition-board calibration described in the supplied manual; Max endpoint calibration cannot fix upstream pairing, sensor seating or damaged data. A diagnostic cross-check is to disconnect Left from D0 and test the Right receiver on that same hardware input: lag following the receiver implicates upstream glove/Bluetooth; lag isolated to D11 implicates that input path. Physical testing is still required before attributing the fault.

Primary sources: [core 1.6.0 SoftwareSerial](https://github.com/arduino/ArduinoCore-renesas/blob/1.6.0/libraries/SoftwareSerial/src/SoftwareSerial.cpp), [its RingBuffer](https://github.com/arduino/ArduinoCore-renesas/blob/1.6.0/libraries/SoftwareSerial/src/RingBuffer.h), [UNO R4 WiFi pin mux](https://github.com/arduino/ArduinoCore-renesas/blob/1.6.0/variants/UNOWIFIR4/pinmux.inc), and [UART implementation](https://github.com/arduino/ArduinoCore-renesas/blob/1.6.0/cores/arduino/Serial.cpp).


A [ready-to-upload hardware variant](../glove_usb_dual_hardware/glove_usb_dual_hardware.ino) is also included with the mode already set to 1. Its wiring guide is in that folder. The generated source differs only in the mode constant and wiring comments; both versions use the same parser, queue and USB logic.
