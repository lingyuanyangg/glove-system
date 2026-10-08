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

UNO R4 WiFi compilation and 32 simulated sketch checks (24 protocol checks plus eight UNO R4 WiFi bridge regressions) passed; see [VALIDATION.md](VALIDATION.md). Physical simultaneous UART timing, pairing, USB, servos and Max/Live integration still require hardware testing. [Chinese instructions](README_中文.md).

## 2026-10-08 transmission fix and diagnostics

Re-upload this corrected firmware if an earlier USB release produced no bytes. The earlier availableForWrite() gate prevented all output on UNO R4 WiFi core 1.6.0; compiling the sketch alone did not expose the issue.

Every second the board now sends `#STATUS,USB2,L,<UART bytes>,<valid frames>,R,<UART bytes>,<valid frames>;` even without glove data. These are diagnostic counters, never finger values. The updated receiver shows them while waiting: zero UART bytes points to the glove/receiver/pin/power link; increasing UART bytes with no valid frames points to baud/framing. Valid L/R frames still follow the original format. No new hand data means no fabricated hand heartbeat.
