# 来源与许可

快照日期：2026-11-17

| 文件夹 | 上游 | 许可 |
|---|---|---|
| `skills/code-animation-prompts` | https://github.com/XiaoyeCodes/code-animation-prompts （原始素材整理：B 站「俯仰观照」） | 免费使用和分享，禁止收费出售；第三方部分（Lemo-Opuscar、mg-styles-15、code-video）为 MIT。见该目录 `UPSTREAM-LICENSE.md`、`assets/library/许可与来源.md`、`assets/library/第三方许可/` |
| `skills/fy-code-animation` | https://github.com/Akillll-DuoHe/fy-code-animation | 免费使用和分享，禁止收费出售。见该目录 `LICENSE.md`、`LICENSES/` |
| `skills/hyperframes*`、`skills/media-use` | HeyGen HyperFrames | 见上游 |
| `skills/remotion-best-practices` | Remotion | 见该目录 `remotion-license/`；Remotion 对部分公司商用收费，团队商用前先确认 |
| `skills/video-use` | video-use | 见该目录 `LICENSE` |
| `skills/seedance2` | seedance2 | 见该目录 `LICENSE` |
| `skills/generative-media` | generative-media | 见该目录 `LICENSE` |
| `skills/jeet-video-style` | 自己整理 | — |

本仓库内的改动：
- `fy-code-animation/adapters/style-library.config.json`：`root` 指向同级 `../code-animation-prompts/assets/library`。
- `code-animation-prompts` 未改动；上游仓库 `docs/images` 的宣传图未收录，`docs/STYLES.md` 照搬。
- 上游仓库根目录的 `install_skill.py` 等脚本换成了 `scripts/install.sh`。
