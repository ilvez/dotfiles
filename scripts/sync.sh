#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_ROOT="$(dirname "$SCRIPT_DIR")"
NVIM_SOURCE="$HOME/.config/nvim"
NVIM_TARGET="$DOTFILES_ROOT/nvim"

echo "Syncing Neovim config..."
echo "Source: $NVIM_SOURCE"
echo "Target: $NVIM_TARGET"

mkdir -p "$NVIM_TARGET"

rsync -av --delete \
  --exclude='lazy-lock.json' \
  --exclude='.git' \
  --exclude='.claude' \
  "$NVIM_SOURCE/" "$NVIM_TARGET/"

echo "Sync complete!"
echo ""
echo "Review changes with: cd $DOTFILES_ROOT && git diff"
