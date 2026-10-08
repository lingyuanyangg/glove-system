# USB dual glove validation

Checked on 2026-10-08. Correction review: the connected UNO R4 WiFi was enumerated and its port was read at 115200 for six seconds, producing zero bytes before the fix. No firmware has yet been uploaded by this review; no servo command was sent by the diagnostic reader.

## Target compilation

Arduino CLI compiled the shipped sketch for `arduino:renesas_uno:unor4wifi` with Arduino UNO R4 Boards 1.6.0, its bundled SoftwareSerial 1.0, and Servo 1.2.1. Default configuration includes the original five servos, driven by Left.

```text
Sketch uses 59648 bytes (22%) of program storage space. Maximum is 262144 bytes.
Global variables use 8056 bytes (24%) of dynamic memory,
leaving 24712 bytes for local variables. Maximum is 32768 bytes.
```

The Servo library was supplied from the local libraries collection:

```sh
arduino-cli compile --fqbn arduino:renesas_uno:unor4wifi \
  --libraries /Users/lingyuanyang/Library/Arduino15/libraries \
  /Users/lingyuanyang/Documents/Arduino/glove_usb_dual
```

On another computer, install Servo through Arduino IDE Library Manager and compile normally. The libraries argument points to a collection of libraries, not Servo's `src` directory.

## Actual sketch logic with simulated ports

`python3 test_usb_dual.py` passed 24 assertions using the shipped INO included into a standalone C++17 program with simulated Arduino, SoftwareSerial and Servo peers. It verifies pin/baud settings, initialization, servo order/directions, exact 11-field framing, whitespace, missing/extra fields, invalid/overflowing integers, angle range, atomic state replacement, independent hands, decimal USB serialization, no repeated stale data, whole-frame overflow/binary rejection and resynchronization, backpressure, newest-frame replacement, pending expiration, output rate limits, bounded port draining, millisecond wraparound and right-port initialization failure with continued Left reception.

Eight additional regression assertions compile the sketch with NO_USB and a UART peer whose availableForWrite() returns zero, matching the installed core. Both hand frames, diagnostic counters, and Right initialization errors still transmit. The old 24-check peer exposed a writable buffer and did not model this target-specific API behavior; that gap allowed the original silent-output bug.

These checks do not emulate UART bit timing, electrical interfaces, DMA, interrupt/timer allocation, the ESP32 USB bridge, actual Bluetooth pairing, or mechanical servo motion.

## Hardware acceptance still required

- Swap the RIGHT module TXD connection from D10 to D11; D10 is software TX, D11 is software RX. Verify supply and signal levels using the supplied module documentation.
- Confirm each receiver is paired with its own glove. Verify the 11-field format at 115200 8N1 on both ports.
- Confirm right SoftwareSerial initializes successfully and both hands stream simultaneously under expected sensor load, with and without servos enabled. Record malformed/missing frames and responsiveness; no zero-loss claim is made.
- Confirm USB serial reception in a monitor, then close that monitor before opening the port from Max.
- The updated Glove Receiver Dual includes the USB serial adapter. See receiver-v2/VALIDATION.md for simulated integration checks. Its live Max/Live connection to this physical firmware has not been tested.

## Pin evidence

ArduinoCore-renesas 1.6.0 maps D11 to P411, which has PIN_INTERRUPT channel 4; D10 maps to P103, which has no PIN_INTERRUPT entry. The SoftwareSerial receiver configures an external pin interrupt, so this sketch uses RX D11 and TX D10.

- [UNO R4 WiFi variant](https://github.com/arduino/ArduinoCore-renesas/blob/1.6.0/variants/UNOWIFIR4/variant.cpp)
- [UNO R4 WiFi pin capabilities](https://github.com/arduino/ArduinoCore-renesas/blob/1.6.0/variants/UNOWIFIR4/pinmux.inc)
- [SoftwareSerial implementation](https://github.com/arduino/ArduinoCore-renesas/blob/1.6.0/libraries/SoftwareSerial/src/SoftwareSerial.cpp)

## Target-specific API evidence and receiver button fix

`boards.txt` defines NO_USB for UNO R4 WiFi; `Arduino.h` then maps Serial to _UART1_. UART in `Serial.h` does not override availableForWrite(), so it inherits the default zero in `api/Print.h`. Its mutable-buffer write waits for transmission. The corrected sketch selects that bulk overload and gates CDC buffering only on native USB targets.

- [Board build defines](https://github.com/arduino/ArduinoCore-renesas/blob/1.6.0/boards.txt)
- [Serial aliases](https://github.com/arduino/ArduinoCore-renesas/blob/1.6.0/cores/arduino/Arduino.h)
- [UART API](https://github.com/arduino/ArduinoCore-renesas/blob/1.6.0/cores/arduino/Serial.h)
- [Print default buffer API](https://github.com/arduino/ArduinoCore-API/blob/master/api/Print.h)

The receiver's USB settings opener now uses trigger bang, because native live.text in button mode emits bang, not the integer 1. Its serial diagnostic parser does not update hand freshness from board status packets.
