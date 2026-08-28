#!/usr/bin/env bash
# Symlink dotfiles from this repo into their live locations.
# Re-run any time to repair links. Existing non-symlink files are backed up.

set -euo pipefail

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"

# repo-relative-path -> absolute destination
declare -A LINKS=(
  [".zshrc"]="$HOME/.zshrc"
  ["gitconfig"]="$HOME/.config/git/config"
  ["bindings.lua"]="$HOME/.config/hypr/bindings.lua"
  ["hypridle.conf"]="$HOME/.config/hypr/hypridle.conf"
  ["input.lua"]="$HOME/.config/hypr/input.lua"
  ["kitty.conf"]="$HOME/.config/kitty/kitty.conf"
  ["shell.json"]="$HOME/.config/omarchy/shell.json"
)

link_one() {
  local src="$REPO_DIR/$1"
  local dest="$2"

  if [[ ! -e "$src" ]]; then
    echo "skip  $dest  (missing source: $src)"
    return
  fi

  mkdir -p "$(dirname "$dest")"

  if [[ -L "$dest" ]]; then
    if [[ "$(readlink "$dest")" == "$src" ]]; then
      echo "ok    $dest"
      return
    fi
    rm "$dest"
  elif [[ -e "$dest" ]]; then
    mv "$dest" "$dest.backup.$STAMP"
    echo "backup $dest -> $dest.backup.$STAMP"
  fi

  ln -s "$src" "$dest"
  echo "link  $dest -> $src"
}

for name in "${!LINKS[@]}"; do
  link_one "$name" "${LINKS[$name]}"
done
