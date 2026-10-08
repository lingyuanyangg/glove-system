# Glove MIDI Trigger

这是独立的 Max for Live **MIDI 效果器**。把 `Glove_MIDI_Trigger.amxd` 与 `glove_midi_trigger.js` 放在同一文件夹，加载到 MIDI 轨道的乐器前面。同一 Live Set 中保留一个已连接 USB 或 OSC 的 Glove Receiver；接收器可在音频轨道上。

![主面板布局预览](ui-layout.png)

左右手各五根手指独立设置：

- **On**：启用／停用；停用立即释放这根手指的音符。
- **Trigger → Accel**：弯曲加速度超过 Threshold 时触发短音；力度由加速度决定。
- **Trigger → Toggle**：弯曲度超过 0.5 时开始持续音，低于 0.45 时释放，避免阈值附近抖动。这里按要求做的是保持模式，不是每次动作切换一次开／关。
- **Pitch → Fixed**：使用 Note 指定音高；**Random**：每次触发随机选取 Root + Scale 音阶内的音，限制在 Low–High 之间。
- **V Min / V Max**：每根手指的力度范围，MIDI 1–127；可以反向设置。Random 的 Low / High 是每根手指独立的最低／最高音。范围内没有音阶音时不发音，状态栏提示修改。

先张开手，再点 **Calibrate 8 s**，在 8 秒内用启用的手指做几次正常力度的触发动作。校准会暂停发音，采集双手共用的加速度基准并保存在设备参数里。没有足够动作时保留旧基准；再次点击可以取消。**Sens %** 越高越敏感；**Threshold** 越高越难触发。**Length ms** 控制 Accel 音长，**Retrig ms** 控制同一手指的最短重复触发间隔。**Panic** 释放设备发出的所有音符。

接口只提供弯曲度，因此这里计算的是“弯曲度变化的加速度”，单位为归一化弯曲度／秒²，不是手套 IMU 的物理加速度。加速度取绝对值，弯曲和伸直动作都可能触发。输入使用真实新帧的 `GLeft` / `GRight`，顺序为小指、无名指、中指、食指、拇指。

**保持音的 Note-on Velocity 不能在发音后直接改变。** Toggle 首次发音的力度来自当时弯曲度，随后更大弯曲会发送 **Poly Aftertouch（多音触后）**；乐器必须支持或映射该信号，才能听到持续力度变化。随机音在一个保持音内不换音。相同音高的多根手指共用一个持续音，最后一根释放时才关闭；要分别演奏，请选不同音高。

设备界面为 Ableton 原生组件，984 × 169，无网页界面或 FluCoMa 依赖。设置和校准基准随 Live Set 保存；持续音不被保存。断流、停用、切换设置、校准或删除设备时释放音符。重新连接或切换 Toggle 时，如果手指已经弯曲，需要先张开到 0.45 以下再触发。

英文技术说明与测试范围见 [README.md](README.md) 和 [VALIDATION.md](VALIDATION.md)。
