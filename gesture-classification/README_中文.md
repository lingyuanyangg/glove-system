# Glove Gesture

[下载 Gesture](Glove%20Gesture.zip) · [英文说明](README.md)

基于 FluCoMa 的手势分类器，可选左手、右手、双手。主界面显示选择／识别到的姿态，Mapping 为独立窗口。安装 Max Package Manager 中的 FluidCorpusManipulation／FluCoMa，将 `Glove_Gesture` 内全部文件保留在一起，加载到音频轨道或乐器后面。

## 训练

先连接并校准 [Receiver](../receiver-v2/README_中文.md)。选择左手／右手，再从下拉菜单选择张手、握拳、食指、V 字、中指或 OK。点击 **Record 2s** 采集，重复多次并加入自然变化。记录的类别自动启用，可用 Include in training 排除。

使用 **Other 2s** 记录放松姿态和过渡动作。每个启用类别及 Other 至少需要 20 个样本。点击 Train，再 Run。界面显示识别姿态；Confirming 正在等待稳定，Confirmed 表示已确认，Other 表示未接受的已知姿态。

双手模式分别选择左右姿态，例如左拳＋右 V，合并成一个十维类别训练。共有 36 种有序组合；左右交换不是同一类。两只手需持续提供有效帧。弯曲度不能单独识别接触、方向或位置，训练时应检查容易混淆的 OK／食指等姿态。

## Mapping 与模型

Mapping 窗口选择左／右／双手的映射视图，点击某行 Map，再点 Live 中暴露的双状态设备参数。× 清除；Show all combinations 展示全部双手组合。可映射 Device On／Off、效果开关等，不能直接映射任意界面按钮或 transport／track 控制。

- Toggle：确认进入时切换一次。
- Pulse：置高后按 Pulse 时间置低。
- Hold：确认期间置高，离开／Stop／断流置低。
- On／Off：进入时写入指定状态。

默认 Hold 120 ms、Gap 350 ms、Pulse 120 ms、Radius 0.18、500 epochs。Radius 是样本距离限制，不是置信概率。保持同一姿态不会重复触发，需要离开再进入。

命名并 Save 模型，在选择器中 Load；Export／Import JSON 可跨 Set 转移，不含 Live 映射目标。保存 Live Set 保留训练库、模型、设置和按钮映射。训练误差不等于新动作识别准确率，应在演奏前测试新的重复动作。
