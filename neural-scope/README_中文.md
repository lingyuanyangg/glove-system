# Glove Neural Scope

[下载 Neural Scope](Glove%20Neural%20Scope.zip) · [英文说明](README.md)

用左手／右手／双手姿态学习目标设备的连续参数。安装 FluidCorpusManipulation／FluCoMa，保留 `Glove_Neural_Scope` 内 AMXD、JS 和 HTML，加载到音频轨道或乐器后面。先连接并校准 [Receiver](../receiver-v2/README_中文.md)。

## 操作

1. **This track** 使用设备所在轨道；**Selected track** 使用 Live 选中轨道。Follow 跟随选中设备；TARGET 手动选择会固定目标。
2. 选择 Left／Right／Both，打开 Scope 选择学习参数；↗ 打开大编辑器。最多 256 个输出，Device On 默认排除。
3. Run 关闭时，摆手套姿态、设置目标声音，再 Capture。建议先采集 8–20 个不同姿态／声音，最低两个；每库最多 512 个。重复近似姿态会拒绝。
4. Train 后 Run，RMSE 是训练误差；用新的动作检查效果，按需增加样本重训。Stop 释放所有参数控制。
5. Min／Max 是参数原生单位的输出限制，不是重新缩放学习结果。Smooth 默认 30 ms，可在 0–500 ms 调整。

切换轨道、目标、输入模式或 Scope 会停止控制。每个目标／输入／Scope 结构拥有独立训练库。改变样本会使其模型需要重新训练。运行时映射会接管参数，Stop 后恢复 Live 自身参数值。

## 模型选择

训练后输入名称并 Save，在 MODEL 中选择并 Load，恢复样本、权重、Scope 和范围，Run 保持关闭。输入模式和目标参数结构必须匹配。最多 128 个命名模型。Export／Import JSON 跨 Set 转移；× 删除快照，不清空工作库。没有自动加载的预置模型。

保存 Live Set 保留模型、训练库和设置。替换／重排设备后先核对目标，再 Run。参数若未暴露，可使用插件的 Configure。

单手输入五个值；双手按左五项＋右五项拼接，手指顺序均为小指、无名指、中指、食指、拇指。本设备保留两手最近的有效值，没有独立的逐手超时或双手时间差检查，断开手套前请 Stop。
