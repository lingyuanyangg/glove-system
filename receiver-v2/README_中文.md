# Glove Receiver Dual

[下载 Receiver](Glove_Receiver_Dual.zip) · [英文说明](README.md)

双手 USB／OSC 接收器，包含各手校准、防抖、弯曲图形和 OSC 转发。界面 648 × 169，作为音频效果器加载，立体声音频直通。

## 安装与 USB

将 `Glove_Receiver_Dual.amxd` 与 `glove_dual_engine.js`、`glove_hands.js`、`glove_usb_serial.js` 放在同一文件夹。每个 Live Set 使用一个 Receiver。

上传 [D12 硬件串口固件](../arduino/glove_usb_dual_hardware/README_中文.md)：左模块 TXD 接 D0，右模块 TXD 接 D12。关闭串口监视器。在 USB… 窗口点击 Refresh，选择板子的端口，再 Open；只选端口不会打开连接。返回 OSC 或 Close 会关闭 USB。保存 Set 后端口名保留，但重新加载时连接保持关闭，需要再 Open。

## 校准与防抖

每手分别打开 Calibrate：张开手稳定至少 0.3 秒，点击 **Open → 0**；握拳稳定至少 0.3 秒，点击 **Fist → 0.9**。两次采集都成功后生效；Reset 恢复该手默认量程。Input 行是校准／滤波前的数据，USB 单位为度。采集拒绝抖动、过期数据和过小量程，完整校准随 Set 保存。

默认 **Smooth 8 ms**、**Deadband 0.003**。降低 Smooth 可提高响应，增加可使数据稳定；Stabilize 关闭时绕过两级滤波。手指顺序为小指、无名指、中指、食指、拇指，数值为 0–1，校准握拳为 0.9，额外弯曲可上浮至 1。手部图形是弯曲度示意。

WAIT 表示尚无数据，LIVE 表示最近有有效输入，HOLD 表示超过一秒没有有效帧，保持最后的数值。USB 状态还显示板子和左右 UART 诊断。

## OSC 与其他设备

OSC 左手端口 7000、右手 6000。`/servos` 接收五个度值；`/GLeft`、`/GRight` 接收五个归一化值。输出时填写 IP／端口，Apply，再启用 OSC Out；发送地址为 `/GLeft`、`/GRight`。

共享 `GLeft`／`GRight` 向 Gesture、Neural Scope、MIDI Trigger 提供新帧；`GLeftControl`／`GRightControl` 向 Mapper 提供滤波变化。消费者可在其他轨道，无需音频接线。训练前先固定校准和滤波设置。
