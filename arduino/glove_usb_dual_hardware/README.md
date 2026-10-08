# Dual glove USB — Right hardware UART

Ready-to-upload UNO R4 WiFi variant generated from `../glove_usb_dual/glove_usb_dual.ino`, with `RIGHT_USE_HARDWARE_UART=1`. It removes SoftwareSerial from the Right input path. It is compiled and logically tested, but physical latency is not yet measured.

**Change Right wiring before upload:** module TXD → **D12** (Arduino RX). Optional module RXD ← **D11** (Arduino TX, compatible signal levels required); for receive-only operation the module RXD may be disconnected. Left stays on D0 RX / D1 TX. Both modules retain 3.3V power and common GND. Do not use the old module TXD → D11 connection with this sketch.

Open `glove_usb_dual_hardware.ino`, select Arduino UNO R4 WiFi and upload. Close the Max USB port first; after upload, reopen USB in Glove Receiver Dual. USB is 115200, 8N1, with the same L/R degree frames and USB3 diagnostics. Default five-servo behavior is inherited from the shared sketch; `ENABLE_SERVOS=0` selects data-only use.

在上传前，将右手模块 **TXD 从 D11 改接 D12**。模块 RXD 可断开；若需要发送则接 D11 并匹配电平。左手接线不变。打开本目录的 INO，选择 UNO R4 WiFi 上传，再在 Receiver 重新 Open USB。本版本已经开启硬件串口，不需要再修改模式开关。尚未实测真实手套的延迟改善。

See the shared [firmware guide](../glove_usb_dual/README.md) and [validation record](../glove_usb_dual/VALIDATION.md). Rebuild this variant with `python3 tools/build_usb_hardware.py` from the repository root; edits belong in the shared sketch.
