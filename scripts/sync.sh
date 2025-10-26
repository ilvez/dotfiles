#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_ROOT="$(dirname "$SCRIPT_DIR")"

GLOBAL_EXCLUDES=(
  "lazy-lock.json"
  ".git"
  ".claude"
)

CONFIGS=(
  ".config/nvim|nvim"
  # ".config/atuin|atuin"
  # ".config/ghostty|ghostty"
  # ".config/direnv|direnv"
)

EXCLUDE_ARGS=()
for exclude in "${GLOBAL_EXCLUDES[@]}"; do
  EXCLUDE_ARGS+=("--exclude=$exclude")
done

for config in "${CONFIGS[@]}"; do
  IFS='|' read -r source target <<< "$config"

  if [[ "$source" = /* ]]; then
    source_path="$source"
  else
    source_path="$HOME/$source"
  fi

  target_path="$DOTFILES_ROOT/$target"
  name="$(basename "$target")"

  echo "Syncing $name..."
  echo "  Source: $source_path"
  echo "  Target: $target_path"

  mkdir -p "$target_path"

  rsync -av --delete "${EXCLUDE_ARGS[@]}" "$source_path/" "$target_path/"

  echo "  ✓ $name synced"
  echo ""
done

echo "Review changes with: cd $DOTFILES_ROOT && git diff"
