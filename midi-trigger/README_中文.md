# Glove MIDI Trigger

[下载 MIDI Trigger](Glove_MIDI_Trigger.zip) · [英文说明](README.md)

将 `Glove_MIDI_Trigger.amxd` 与 `glove_midi_trigger.js` 放在一起，加载到 **MIDI 轨道的乐器前面**。同一个 Set 保留已连接的 [Receiver](../receiver-v2/README_中文.md)。左右手十根手指独立控制。

## 每根手指

- **On**：启用／停用，停用释放音符。
- **Accel**：弯曲加速度超过阈值时发短音，动作越强力度越大。
- **Toggle**：弯曲度高于 0.5 保持音符，低于 0.45 释放；加载／重启／重新连接后先回到张手姿态。
- **Fixed**：Note 指定音高；**Random**：按 Root／Scale 音阶在 Low–High 间随机选音，每次触发选一次。
- **V Min／V Max**：每根手指的力度范围，MIDI 1–127，可反向；随机音域为 MIDI 0–127，范围内无音阶音时不发音。

## 全局校准

点击 **Calibrate 8 s**，用启用手指做几次正常力度动作。采集期间不发音，双手共用一个参考量，完成后保存在 Cal ref／s²。动作不足保留原值；再次点击取消。

**Sens %** 越高越敏感，**Threshold** 越高越难触发；**Length ms** 是短音长度，**Retrig ms** 是同手指的最短触发间隔。**Panic** 释放设备生成的音符。保存 Set 保留设置和校准，持续音不保存。

加速度来自弯曲度随时间的变化，不是 IMU 的物理加速度。Toggle 起音 Velocity 取当时弯曲度，随后持续变化发送 **Poly Aftertouch**，需乐器支持才有连续力度效果，不会连续重触发音符。相同音高的手指共用一声部，最后一根释放才关闭；要独立演奏请选择不同音高。断流、停用、切换设置、校准和删除设备均释放生成的音符。
