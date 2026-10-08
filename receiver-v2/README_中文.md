# Glove Receiver Dual USB 更新

现在同一个接收器支持 OSC 与 USB 两种输入。主界面保持 808 × 169，底部增加 Input 和 USB…；点击 USB… 打开独立原生设置窗口，包含 Port、Refresh、Open、Close 和状态。两只手的五个参数仍使用原来的归一化、防抖、Ableton 映射及 OSC 转发。

## 使用 USB

1. Arduino UNO R4 WiFi 烧录 `arduino/glove_usb_dual/glove_usb_dual.ino`。左手 TXD 接 D0；**右手 TXD 必须接 D11**，D10 是可选的软件 TX。接收模块使用 3.3V 供电、共地，信号电平应匹配。右手 TXD 接 D10 的接法不适用于这套标准 SoftwareSerial 实现。
2. 关闭 Arduino 串口监视器及其他占用串口的软件。重新加载更新后的 AMXD；点击 USB… 打开设置窗口，再点击 Refresh，选择实际 Arduino USB 串口，再点击 Open。Open 会自动切换到 USB。
3. USB 使用 115200、8N1，接收下面的角度格式。左右手都有数据时显示 `USB · L / R`；只有一只手有数据时显示对应手。没有数据时显示 waiting，不将等待状态当作成功配对。
4. 上传新固件或让其他软件使用串口前点击 Close。Input 切回 OSC 也会关闭 USB。USB 模式关闭 OSC 数据通路，避免网络与 USB 同时混入；两个 UDP 接收对象仍占用 7000/6000，其他设备不要重复绑定。

```text
L,180.0,160.0,150.0,149.0,134.5;
R,170.0,152.0,149.4,158.0,132.1;
```

每帧必须是 L/R 加五个 0–180 的角度值，分号结束。固件已经将原始值除以十，接收器不会再除一次。通道顺序沿用原设备：小指、无名指、中指、食指、拇指。请核对两只手的实际传感器顺序及校准范围。

串口数据送入原有 rawleft/rawright 校准与滤波。坏帧、字段缺失/多余、溢出、非法字节和超时片段被丢弃。固件的右手初始化错误会显示为 Right init error，不作为手指数据。

## 训练与运行

`GLeft` / `GRight` 现在随新的真实输入持续发送滤波后的五个值，即使保持静止手势也不会因没有数值变化而被分类/回归设备认为断流。没有真实新输入时不会伪造心跳。界面、参数映射和 OSC 转发仍只在数值变化时更新；一秒无输入显示 HOLD，连续参数映射维持最后的值。

## 安装与回忆

`Glove_Receiver_Dual.amxd`、`glove_dual_engine.js`、`glove_hands.js`、`glove_usb_serial.js` 四个运行文件必须同目录；maxpat 是可编辑源码。请重新加载完整设备，不能只给旧 AMXD 替换 JS。更新前的已安装文件夹已保留为本地备份，旧 Set 中的设备需检查映射及状态。

保存 Live Set 会保存输入模式和串口名称，不保存菜单序号。**重新载入后串口保持关闭**，确认后点击 Open。Max 的原生 serial 对象负责枚举与读取，不需要 Python 或 Node 桥接。若系统没有识别串口，需按 Arduino/接收硬件的说明安装相应驱动。

离线算法、串口消息与双手联动检查通过；实际 Max/Live 串口连接、重新载入、界面和真实手套仍待实机验证，见 VALIDATION.md。
