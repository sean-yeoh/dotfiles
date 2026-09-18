#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "$0")"

platform="$(uname)"

if [[ "$platform" == "Darwin" ]]; then
  brew bundle install --file=Brewfile
fi

sh ./stow.sh

if [[ "$platform" == "Darwin" ]]; then
  domain="gui/$(id -u)"
  agent="$domain/com.seanyeoh.backup-dotfiles"
  plist="$HOME/Library/LaunchAgents/com.seanyeoh.backup-dotfiles.plist"

  plutil -lint "$plist"
  if launchctl print "$agent" >/dev/null 2>&1; then
    launchctl bootout "$agent"
  fi
  launchctl bootstrap "$domain" "$plist"
fi
