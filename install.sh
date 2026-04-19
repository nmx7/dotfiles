#!/usr/bin/env bash

# <https://www.reddit.com/r/linux4noobs/comments/b5ig2h/is_there_any_way_to_force_gnu_stow_to_overwrite/>
# Have the files inside a git repository
# stow --adopt *
# git restore .
# Stow will create a symlink and overwrite the files inside your repository and git will undo the changes and return to the original files but the symlinks will stay there.

set -x
set -euo pipefail

IFS=$'\n\t'

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "$DOTFILES_DIR"

DRY_RUN=""
VERBOSE=""

usage() {
    echo "Usage: $0 [--dry-run] [--verbose] [--help]"
    echo ""
    echo "  --dry-run   Simulate stow operations without making changes"
    echo "  --verbose   Enable command tracing (set -x)"
    echo "  --help      Show this help message"
    exit 0
}

for arg in "$@"; do
    case "$arg" in
        --dry-run)  DRY_RUN="--simulate" ;;
        --verbose)  VERBOSE=1 ;;
        --help)     usage ;;
        *) echo "Unknown argument: $arg" >&2; usage ;;
    esac
done

[[ -n "$VERBOSE" ]] && set -x

if ! command -v stow &>/dev/null; then
    echo "Error: GNU stow is not installed." >&2
    exit 1
fi

packages=(git zsh vim nvim tmux ssh fastfetch)
for pkg in "${packages[@]}"; do
    stow $DRY_RUN --adopt "$pkg"
done

OS="$(uname -s)"

if [ "$OS" = "Darwin" ]; then
    sudo stow $DRY_RUN --adopt --target=/usr/local bin
else
    stow $DRY_RUN --adopt bin
fi

git -C "$DOTFILES_DIR" restore .
