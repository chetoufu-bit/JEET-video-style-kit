# Jeet 视频风格整理包

做视频用的提示词、风格库和技能（skill），整合在一个仓库里，Claude Code 和 Codex 都能装。入口是 `skills/jeet-video-style/`：先定规格和品牌风格，再告诉 AI 该用哪个子技能。

## 里面有什么

| 技能 | 作用 | 来源 |
|---|---|---|
| `jeet-video-style` | **总入口**：默认规格（9:16 竖屏）、Card2Dream 品牌配色字体、选哪个技能的路由表、铁律 | 自己整理 |
| `code-animation-prompts` | 341 种代码动画风格提示词 + 193 张参考静帧 + 离线挑选器 `assets/library/风格挑选.html` | XiaoyeCodes/code-animation-prompts |
| `fy-code-animation` | 文案 → 语义分镜 → 选画风 → 镜头/转场/字体/声音 → Remotion/Canvas 落地 → 返修；已接好上面的风格库 | Akillll-DuoHe/fy-code-animation |
| `hyperframes` / `hyperframes-cli` / `hyperframes-registry` | HTML 写动画渲染成视频；约 450 个现成转场、字幕、图表块 | HeyGen HyperFrames |
| `remotion-best-practices` | Remotion（React 视频）全套：创建、字幕、地图、交互等 | Remotion |
| `video-shotcraft` | 电影感产品宣传片：真实页面截图 + 2.5D 运镜 + 节奏卡点 + 音效；152 张镜头配方卡、209 个样式、Ink Press 成片模板（Remotion） | kingselyjoe/video-shotcraft-dsh |
| `media-use` | 配乐、音效、配音、抠像、调色 | HyperFrames |
| `video-use` | 对话式剪辑：转写、剪辑、调色、烧字幕（含 manim） | video-use |
| `seedance2` | 即梦 Seedance 图生视频、运镜、短剧提示词 | seedance2 |
| `generative-media` | 生图、图生视频、口型、音乐（API） | generative-media |

341 种风格的可点击目录：[docs/STYLES.md](docs/STYLES.md)。

**可视化挑选台** `picker/`：画风（带参考图和提示词原文）、15 种镜头运动、16 种转场都有循环动画演示，点 ＋ 加入清单后一键复制发给 Claude。本地打开要起个服务：`cd picker && python3 -m http.server`，再访问 http://localhost:8000。

## 安装

```sh
git clone https://github.com/chetoufu-bit/JEET-video-style-kit.git
cd JEET-video-style-kit
./scripts/install.sh          # 装到 ~/.claude/skills 和 ~/.codex/skills
```

只装一边用 `./scripts/install.sh claude` 或 `./scripts/install.sh codex`。同名旧技能会先备份成 `.bak-时间`。

在 claude.ai 网页/桌面版用：把 `skills/` 下需要的文件夹分别打成 zip，在 设置 → Capabilities → Skills 上传；`jeet-video-style` 建议一定要传。

## 怎么用

直接说要做什么视频就行，比如"做一条 15 秒的 DP 福利竖屏动效，风格用 B3"。AI 会先读 `jeet-video-style`，再按路由去读对应技能。挑风格可以打开 `skills/code-animation-prompts/assets/library/风格挑选.html`，选好后把编号发过去。

## 更新上游

各技能是从上游复制进来的快照（日期见 [SOURCES.md](SOURCES.md)）。上游有新版本时，让 Claude 重新拉取并覆盖对应文件夹即可；`fy-code-animation/adapters/style-library.config.json` 里的 `root` 改过，覆盖后要改回 `../code-animation-prompts/assets/library`。

## 许可

各技能保留自己的许可文件。code-animation-prompts 和 fy-code-animation 的素材约定是**免费使用、免费分享，不得包装成付费课程或付费 skill 出售**。本仓库仅供个人和团队内部使用。详见 [SOURCES.md](SOURCES.md)。
