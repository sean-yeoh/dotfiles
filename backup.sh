#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "$0")"

if [[ "$(uname)" == "Darwin" ]]; then
  brew bundle dump --file=Brewfile --force
fi

git add .
if ! git diff --cached --quiet; then
  git commit -m "Backup $(date '+%Y-%m-%d %H:%M:%S')"
fi
git push