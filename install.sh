#!/usr/bin/env bash
# Symlink every tracked macOS dotfile in this repo into $HOME.
# Anything already there is moved to <name>.pre-dotfiles first, never deleted.
# Skips linux/, README.md, install.sh and .gitignore.
# New configs are linked automatically once git tracks them — no edit needed here.
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
cd "$REPO"

should_skip() {
  case "$1" in
    linux/*|README.md|install.sh|.gitignore) return 0 ;;
    *) return 1 ;;
  esac
}

link_file() {
  local f="$1"
  local target="$HOME/$f"
  local src="$REPO/$f"

  mkdir -p "$(dirname "$target")"

  if [ -L "$target" ] && [ "$(readlink "$target")" = "$src" ]; then
    echo "ok       $f"
    return
  fi

  if [ -e "$target" ] || [ -L "$target" ]; then
    mv "$target" "$target.pre-dotfiles"
    echo "backup   $f -> $f.pre-dotfiles"
  fi

  ln -s "$src" "$target"
  echo "linked   $f"
}

while IFS= read -r f; do
  should_skip "$f" && continue
  link_file "$f"
done < <(git ls-files)

# Ghostty cursor shaders are a third-party repo, so they're cloned, not copied.
mkdir -p "$HOME/.config/ghostty"
if [ ! -d "$HOME/.config/ghostty/shaders" ]; then
  git clone https://github.com/sahaj-b/ghostty-cursor-shaders "$HOME/.config/ghostty/shaders"
fi
