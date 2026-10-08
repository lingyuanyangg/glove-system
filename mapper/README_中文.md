# Glove Mapper 独立映射器

Receiver 的十组映射已拆成独立音频效果设备。左手、右手各五组，包含只读 0–1 数字、Map、×、Min 和 Max，界面为 Ableton 原生组件，388 × 169。

保留 `Glove_Mapper.amxd` 与 `glove_mapper.js` 在同一文件夹。加载到音频轨或乐器之后。Set 中使用一个新版 Receiver，连接 USB/OSC 并在 Receiver 中校准。Mapper 可以放在另一条轨道，自动接收 GLeft / GRight，不需要额外连接。

点击 Map 后点击 Live 参数，× 解除映射。Min / Max 是目标范围的 0–100%，支持反向及固定输出；例如 20% / 80%，张手到 20%，握拳 0.9 到 74%，弯曲上浮到 1 到 80%。保存 Set 会保存 Mapper 的目标和范围。Live 音频引擎需要运行。

防抖、校准和平滑统一在 Receiver 完成。Mapper 不增加第二层平滑，控制更新不等待约 30fps 的数字刷新。新版 Receiver 还发送 GLeftControl / GRightControl，将真实帧之间的平滑更新立即送到 Mapper，原来的分类和回归数据接口不变。

WAIT 表示未收到真实帧，LIVE 为近期收到，超过一秒没有真实帧为 HOLD。HOLD 保持最后参数与映射；它不是蓝牙原始采样的时间测量。

旧 Receiver 的映射不会自动搬到另一个设备，需要在 Mapper 中重新 Map 并设置范围。已备份旧版 Receiver。旧 Set 已加载的设备不会仅因磁盘文件更新而自动变成新版；替换时不要同时运行两套 Receiver，以免争用端口。

离线控制、Min/Max 算法与结构检查通过，实际 Live 验证情况见 VALIDATION.md。
