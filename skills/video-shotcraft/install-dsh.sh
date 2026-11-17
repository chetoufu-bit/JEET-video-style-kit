#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"
PYTHON="${PYTHON:-python3}"
if ! command -v "$PYTHON" >/dev/null 2>&1; then
  echo "Python 3.10+ is required by the DSH package manager." >&2
  exit 1
fi
for command in node npm npx; do
  command -v "$command" >/dev/null 2>&1 || { echo "$command is required." >&2; exit 1; }
done

"$PYTHON" scripts/dsh_manager.py install "$@"
"$PYTHON" scripts/dsh_manager.py doctor
