# Arduino USB 双手桥接 · D12 硬件串口

[下载固件](Glove_USB_D12.zip) · [英文说明](README.md)

用于 Arduino UNO R4 WiFi 和两只已与手套配对的蓝牙 UART 接收模块。电脑端使用一根 USB 线；手套到模块仍通过蓝牙连接。

## 接线与上传

| 模块 | TXD → Arduino 接收 | 可选 Arduino 发送 → 模块 RXD |
| --- | --- | --- |
| 左手 | **D0** | D1 |
| 右手 | **D12** | D11 |

模块使用指定的 3.3V 电源，双方共地。只接收手套数据时，两只模块 RXD 都可不接。UNO R4 WiFi 的 TX 为 5V，若模块 RXD 不耐 5V，接回传线前需要合适的电平转换。

1. 在 Arduino IDE 打开 `glove_usb_dual_hardware.ino`。
2. 安装 UNO R4 开发板包和 Servo 库，选择 **Arduino UNO R4 WiFi** 和对应端口。
3. 固件已启用右手 D12 硬件串口。纯数据用途可将 `ENABLE_SERVOS` 改为 0；默认五路舵机使用 6、5、4、3、2 引脚，`SERVO_HAND` 选择左手 0 或右手 1。
4. 先关闭 Max 的 USB 连接，再上传。上传后关闭 Arduino 串口监视器。
5. 在 [Receiver](../../receiver-v2/README_中文.md) 的 USB… 窗口点击 Refresh，选择端口并 Open。

## 协议

两路 UART 和 USB 均为 115200、8N1。输入必须是 11 个逗号分隔整数，以分号结束；前五项是十分之一度，范围 0–1800，顺序为小指、无名指、中指、食指、拇指。后六项校验后忽略。

USB 输出 `L,180.0,160.0,150.0,149.0,134.5;` 或 `R,...;`，单位已转换为度。每手最多每秒 50 个新帧，无新数据不重复发姿态。每秒的 `#STATUS,USB3,...;` 是串口诊断，不是手指值；右串口初始化失败会输出错误并亮板载 LED。固件不负责蓝牙扫描／配对。
