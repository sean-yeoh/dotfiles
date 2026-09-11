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

# Preview
stow --simulate --verbose --target="$HOME" .

if [ "${1-}" = --preview ]; then
    exit 0
fi

# Apply
stow --target="$HOME" .
