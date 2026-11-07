#!/usr/bin/env bash
# Symlink every Mac dotfile in this repo into $HOME.
# Anything already there is moved to <name>.pre-dotfiles first, never deleted.
# Skips linux/, README.md, install.sh and git files.
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
cd "$REPO"

git ls-files | grep -vE '^(linux/|README\.md$|install\.sh$|\.gitignore$)' | while read -r f; do
  target="$HOME/$f"
  src="$REPO/$f"
  mkdir -p "$(dirname "$target")"
  if [ -L "$target" ] && [ "$(readlink "$target")" = "$src" ]; then
    echo "ok       $f"
    continue
  fi
  if [ -e "$target" ] || [ -L "$target" ]; then
    mv "$target" "$target.pre-dotfiles"
    echo "backup   $f -> $f.pre-dotfiles"
  fi
  ln -s "$src" "$target"
  echo "linked   $f"
done

# Ghostty cursor shaders are a third-party repo, so they're cloned, not copied.
if [ ! -d "$HOME/.config/ghostty/shaders" ]; then
  git clone https://github.com/sahaj-b/ghostty-cursor-shaders "$HOME/.config/ghostty/shaders"
fi
