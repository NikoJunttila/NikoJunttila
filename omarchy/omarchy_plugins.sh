#!/usr/bin/env bash
# Clone omarchy shell plugins tracked by this dotfiles repo.
# Idempotent: skips plugins that are already cloned.
#
# shell.json (symlinked by install.sh) already lists these in the bar
# layout, so once cloned they show up on next `omarchy restart shell`.
# --enable is belt-and-suspenders for plugins whose own install.sh also
# patches shell.json / disabledPlugins itself.

set -euo pipefail

PLUGINS_DIR="$HOME/.config/omarchy/plugins"

# plugin-id -> git repo url
declare -A PLUGINS=(
  [omarchy-lock-style]="https://github.com/MrDemonc/Omarchy-lock-style.git"
)

mkdir -p "$PLUGINS_DIR"

for id in "${!PLUGINS[@]}"; do
  dest="$PLUGINS_DIR/$id"

  if [[ -d "$dest" ]]; then
    echo "ok    $id already cloned"
    continue
  fi

  echo "==> Cloning $id"
  git clone "${PLUGINS[$id]}" "$dest"

  if [[ -x "$dest/install.sh" ]]; then
    (cd "$dest" && ./install.sh --enable --restart)
  fi
done

echo "==> Done"
echo "Run 'omarchy restart shell' if the bar didn't refresh."
