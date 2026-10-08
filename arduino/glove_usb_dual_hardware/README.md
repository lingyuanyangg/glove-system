# Arduino USB bridge · D12 hardware UART

Dual-hand USB firmware for **Arduino UNO R4 WiFi** and the ElastremeSense Manu-5D glove system. Left uses `Serial1`; Right uses a dedicated SCI0 hardware UART. Both streams are forwarded through one USB serial connection. Glove-to-receiver pairing remains the kit's Bluetooth connection.

[Download firmware](Glove_USB_D12.zip) · [中文操作说明](README_中文.md)

## Wiring

| Receiver | Module TXD → Arduino RX | Optional Arduino TX → module RXD |
| --- | --- | --- |
| Left | **D0** | D1 |
| Right | **D12** | D11 |

Use the supplied receivers' 3.3 V power and common GND. For receive-only use, leave their RXD pins disconnected. UNO R4 WiFi TX signals are 5 V; a module RXD that is not 5 V tolerant needs appropriate level conversion before an optional return connection. Both receivers must already be paired with their gloves.

## Upload and connect

1. Open `glove_usb_dual_hardware.ino` in Arduino IDE.
2. Install the Arduino UNO R4 board package and Servo library. Select **Arduino UNO R4 WiFi** and the board's USB port.
3. `RIGHT_USE_HARDWARE_UART` is enabled. For data-only operation, set `ENABLE_SERVOS=0`; otherwise five servo outputs are enabled on pins 6, 5, 4, 3 and 2. `SERVO_HAND` selects Left (0) or Right (1) for those outputs.
4. Close the Receiver's USB port, then upload. Close Arduino Serial Monitor afterwards.
5. In [Glove Receiver Dual](../../receiver-v2/README.md), open USB…, click Refresh, choose the board's port and Open.

## Data format

Inputs use 115200, 8N1 and exactly eleven comma-separated integers ending in `;`. The first five are angles in tenths of a degree, 0–1800, ordered pinky, ring, middle, index, thumb. The remaining six are validated and ignored.

```text
1800,1600,1500,1490,1345,0,0,0,0,0,0;
```

USB uses 115200, 8N1 and emits labeled degree values, at most 50 fresh frames/s per hand:

```text
L,180.0,160.0,150.0,149.0,134.5;
R,170.0,152.0,149.4,158.0,132.1;
```

Independent buffers validate frames atomically and retain the latest complete pose in a burst. A newline follows each semicolon. Pending data older than 100 ms are discarded. No new hand data means no repeated pose frame.

A one-second `#STATUS,USB3,...;` packet reports each UART's byte, valid-frame, bad-frame and queue-peak counters. These are diagnostics, not hand data. `#ERROR,RIGHT_SERIAL_INIT;` reports Right UART initialization failure and lights the onboard LED. The LED does not indicate Bluetooth pairing.

The five servo outputs use Left by default; the first four directions are reversed and thumb is direct. Servo power/mechanics are separate from serial input. The sketch does not scan/pair Bluetooth devices or configure Wi-Fi. See the [technical specification](../../docs/TECHNICAL.md) for queue handling and complete protocol details.
