#!/bin/sh
set -eu

if [ "$#" -gt 1 ]; then
    printf 'Usage: %s [--preview]\n' "$0" >&2
    exit 2
fi

case "${1-}" in
    ''|--preview) ;;
    *)
        printf 'Usage: %s [--preview]\n' "$0" >&2
        exit 2
        ;;
esac

cd -- "$(dirname -- "$0")"

preview="${1-}"
platform="$(uname)"

# Preview
# Keep runtime data beside common configuration files outside the repository.
stow --simulate --verbose --no-folding --target="$HOME" common
# Link ~/.agents/skills as one folder, so skill installers write into the repository.
mkdir -p "$HOME/.agents"
stow --simulate --verbose --dir=common --target="$HOME/.agents" .agents
if [ "$platform" = "Darwin" ]; then
    stow --simulate --verbose --target="$HOME" mac
fi

if [ "$preview" = --preview ]; then
    exit 0
fi

# Apply
stow --no-folding --target="$HOME" common
stow --dir=common --target="$HOME/.agents" .agents
if [ "$platform" = "Darwin" ]; then
    stow --target="$HOME" mac
fi
