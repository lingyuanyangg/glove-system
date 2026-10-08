# 双手手套 USB 固件

适用 Arduino UNO R4 WiFi，使用 Arduino UNO R4 Boards 1.6.0 自带的 SoftwareSerial，以及 Servo 1.2.1。原来的 glove/glove.ino 保留不变。本程序不使用 Wi-Fi 或 OSC。

## 接线

**右手模块当前 TXD 接 D10、RXD 接 D11 的接法需要调换。** UNO R4 WiFi 的 D10 不具备标准 SoftwareSerial 接收所需的中断能力；D11 可以作为接收脚。因此软件串口定义是 `SoftwareSerial rightGlove(11, 10)`，参数顺序为 RX、TX。

| 接收器 | 模块 TXD → Arduino 接收 | 模块 RXD ← Arduino 发送 |
| --- | --- | --- |
| 左手 | D0，Serial1 RX | D1，Serial1 TX，可选 |
| 右手 | D11，软件 RX | D10，软件 TX，可选 |

两块模块的 VDD 接 3.3V，GND 与 Arduino 共地。手套说明明确要求模块使用 3.3V 供电，不要接 5V。信号电平也需要匹配：Arduino 的 5V TX 输出不能直接认定为模块 RX 可接受，应使用适合 UART 的电平转换。仅接收手套数据时，模块 RXD 可不接；按实际模块电平要求连接模块 TXD 与 Arduino RX。

模块应已分别与对应手套配对；这段代码处理 UART 数据，不执行蓝牙扫描/配对或修改模块 AT 设置。

## 上传与设置

打开 `glove_usb_dual.ino`，选择 **Arduino UNO R4 WiFi** 和实际 USB 串口，编译、上传。串口监视器设为 **115200**。在 Max 打开同一串口前关闭串口监视器。

- 默认保留原来的五个舵机，使用左手数据；引脚 D6、D5、D4、D3、D2，前四个反向，第五个正向。
- 只用于手套数据时，将 `ENABLE_SERVOS` 改成 `0`。
- 让这五个舵机使用右手数据时，将 `SERVO_HAND` 改成 `1`。这不是十个舵机的双机械手控制程序。
- 软件串口初始化失败时，板载 LED 常亮，USB 每秒输出 `#ERROR,RIGHT_SERIAL_INIT;`，左手接收继续工作。LED 不用于判断蓝牙是否已连接。

## 输入和 USB 输出

按 Manu-5D 说明接收完整帧：115200、8N1，11 个整数以逗号分隔、分号结束。前五个数据使用 0–1800 的十分之一度单位，后六个字段仍检查整数格式，但不用于控制。字段缺失、多出字段、错误字符、溢出、前五个值超出范围都会丢弃该帧，不产生新输出或改变舵机。

USB 输出只保留五个有效值，单位变成角度，保留一位小数。每帧以分号和换行结束：

```text
L,180.0,160.0,150.0,149.0,134.5;
R,170.0,152.0,149.4,158.0,132.1;
```

`L` 为左手，`R` 为右手；五个值维持原来传感器通道顺序。代码不根据图片推断手指顺序。左右手采用独立帧缓冲；输出最多各 50 帧/秒，保留最新完整帧，超过 100ms 未能输出则丢弃。UNO R4 WiFi 的 Serial 实际使用通往 ESP32 USB 桥的 UART，当前核心的 availableForWrite() 返回 0，因此修正版直接使用短帧批量 write，不再以此检查阻止发送。UART 写入会等待发送完成（115200 下 40 字节约 3.5ms），期间中断仍工作；这不是完全非阻塞的发送器。没有新数据时不会重复发送旧值。舵机按原逻辑将角度四舍五入为整数控制。

更新后的 Glove Receiver Dual 已加入 USB 输入。关闭 Arduino 串口监视器，在接收器中点击 USB… 打开设置窗口，再点击 Refresh，选择 Arduino USB 串口，再点击 Open。接收器会切换到 USB，通过 `serial` 读取字节，按 `;` 分帧，将 L/R 的五个角度送入原有归一化、防抖流程，并输出到 `GLeft` / `GRight`。切换回 OSC 或点击 Close 会关闭串口；保存的 Set 重新打开后，串口保持关闭，需要再次 Open。`#` 开头是错误状态，不是手套数据。

## 验证范围

见 VALIDATION.md。目标板编译、解析和输出逻辑可以离线检查；两个真实接收器同时以 115200 发送、软件串口与舵机并用、USB 实际连接仍需要板上测试。程序不增加舵机断线回中行为，延续原设备最后位置。

参考：用户提供的 Manu-5D 套件说明；ArduinoCore-renesas 1.6.0 的 UNOWIFIR4/variant.cpp、pinmux.inc 与 SoftwareSerial 源码。

## 本次 USB 无输出修复

早期版本的 availableForWrite() 判断会让 UNO R4 WiFi 完全不输出 USB 数据。**必须重新上传修正版 glove_usb_dual.ino**。

修正版每秒还输出一条 `#STATUS,USB2,L,接收字节数,有效帧数,R,接收字节数,有效帧数;`。没有手套输入也能确认 Arduino 到电脑的链路。Receiver 等待时显示这些计数：

- `board OK`：收到本版本固件的状态包。
- UART bytes L/R 为 0：相应串口没有收到字节，需要检查配对、供电、共地和 TXD 引脚。
- UART bytes 增长、frames 不增长：收到字节，但不是规定的 11 字段完整帧，检查 115200/8N1 与数据格式。
- `board status stale`：超过两秒没有新的板子状态包。

状态包不参与归一化、映射或训练，也不会假造左右手数据。
