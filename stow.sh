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
set -- common
if [ "$(uname)" = "Darwin" ]; then
    set -- "$@" mac
fi

# Preview
stow --simulate --verbose --target="$HOME" "$@"

if [ "$preview" = --preview ]; then
    exit 0
fi

# Apply
stow --target="$HOME" "$@"
