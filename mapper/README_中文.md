# Glove Mapper

[下载 Mapper](Glove_Mapper.zip) · [英文说明](README.md)

十根手指独立映射，界面 388 × 169，每根包含数值、Map、×、Min 和 Max。作为音频效果器加载到音频轨道或乐器后面，音频直通。

1. 将 `Glove_Mapper.amxd` 与 `glove_mapper.js` 放在同一文件夹。
2. 在同一个 Set 中连接并校准 [Receiver](../receiver-v2/README_中文.md)。
3. 点击手指的 **Map**，再点击 Live 参数；**×** 释放映射。
4. **Min／Max** 是目标原生范围的百分比，默认 0／100；反向设置可以反转，设为相同值则固定输出。
5. 保存 Live Set 保留目标和范围，使用时保持 Live 音频引擎开启。

例如 Min 20、Max 80：张手 0 输出目标范围的 20%，校准握拳 0.9 输出 74%，弯曲 1 输出 80%。滤波来自 Receiver，Mapper 不再加一层平滑。

共享数据顺序为小指、无名指、中指、食指、拇指。WAIT 为未收到有效新帧，LIVE 为最近有数据，HOLD 为超过一秒无新帧，保留最后数值及映射。数据可跨轨道，不需要音频路由。
