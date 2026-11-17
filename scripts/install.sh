#!/usr/bin/env bash
# 把整理包里的技能装到 Claude Code 和/或 Codex 的 skills 目录。
# 用法：
#   ./scripts/install.sh            # 两个都装（~/.claude/skills 和 ~/.codex/skills）
#   ./scripts/install.sh claude     # 只装 Claude Code
#   ./scripts/install.sh codex      # 只装 Codex
#   ./scripts/install.sh /自定义/skills目录
# 已存在的同名技能会先备份成 <名字>.bak-<时间>，不会直接覆盖。
set -euo pipefail
HERE="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$HERE/skills"
TS="$(date +%Y%m%d-%H%M%S)"

case "${1:-all}" in
  all)    TARGETS=("$HOME/.claude/skills" "$HOME/.codex/skills") ;;
  claude) TARGETS=("$HOME/.claude/skills") ;;
  codex)  TARGETS=("$HOME/.codex/skills") ;;
  *)      TARGETS=("$1") ;;
esac

for dst in "${TARGETS[@]}"; do
  mkdir -p "$dst"
  for skill in "$SRC"/*/; do
    name="$(basename "$skill")"
    if [ -e "$dst/$name" ]; then
      mv "$dst/$name" "$dst/$name.bak-$TS"
      echo "已备份旧版本：$dst/$name.bak-$TS"
    fi
    cp -R "$skill" "$dst/$name"
  done
  echo "✓ 已安装到 $dst"
done
echo "装完重启 Claude Code / Codex 即可。确认没问题后可以删掉 *.bak-* 备份。"
