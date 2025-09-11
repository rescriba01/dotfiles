#!/usr/bin/env bash

DOTFILES_DIR="$HOME/.dotfiles"
STOW_DIR="$DOTFILES_DIR/stow"

# make sure stow/ exists
mkdir -p "$STOW_DIR"

# move all topic directories into stow/, excluding stow/, bootstrap/, and scripts/
for dir in "$DOTFILES_DIR"/*/; do
  name=$(basename "$dir")
  if [ "$name" != "stow" ] && [ "$name" != "bootstrap" ] && [ "$name" != "scripts" ]; then
    echo "Moving $name → stow/"
    mv "$dir" "$STOW_DIR/"
  fi
done
