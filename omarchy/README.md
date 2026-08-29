# omarchy dotfiles

Personal config for an Omarchy Linux setup. Everything here gets symlinked
(or bootstrapped) into place by the scripts below — nothing is edited
directly at its live location.

## Layout

| File | Symlinked to | What it is |
|---|---|---|
| `.zshrc` | `~/.zshrc` | Zsh + Oh My Zsh + Powerlevel10k config |
| `gitconfig` | `~/.config/git/config` | Git aliases and defaults |
| `bindings.lua` | `~/.config/hypr/bindings.lua` | Hyprland keybinding overrides |
| `input.lua` | `~/.config/hypr/input.lua` | Keyboard layout / input overrides |
| `hypridle.conf` | `~/.config/hypr/hypridle.conf` | Idle/lock/screensaver timeouts |
| `kitty.conf` | `~/.config/kitty/kitty.conf` | Kitty terminal config |
| `shell.json` | `~/.config/omarchy/shell.json` | Omarchy bar layout, idle settings, enabled plugins |

`zsh_plugins.sh`, `secrets-setup.sh`, and `omarchy_plugins.sh` are one-shot
bootstrap scripts, not symlinked — see below.

## Fresh machine setup

```bash
git clone https://github.com/NikoJunttila/NikoJunttila.git
cd NikoJunttila/omarchy

./install.sh            # symlink dotfiles into place (backs up existing files)
./zsh_plugins.sh         # install Oh My Zsh + zsh-autosuggestions + zsh-syntax-highlighting
./secrets-setup.sh       # create ~/.config/secrets/env template (fill in real values after)
./omarchy_plugins.sh     # clone tracked omarchy shell plugins
omarchy restart shell    # apply shell.json + plugins
```

All scripts are idempotent — safe to re-run any time to repair a broken
symlink or pick up a newly added plugin.

## `install.sh`

Symlinks each file in its `LINKS` map to its destination. If something
already exists at the destination and isn't already the right symlink, it's
backed up as `<dest>.backup.<timestamp>` rather than overwritten.

To track a new dotfile: add the file to this directory and add a
`["repo-file"]="$HOME/absolute/dest"` entry to the `LINKS` array in
`install.sh`.

## `omarchy_plugins.sh`

Omarchy shell plugins (bar widgets like `omarchy-lock-style`) aren't part of
Omarchy's own config — each one is a separate git repo cloned into
`~/.config/omarchy/plugins/<id>/`. This script holds the list of plugins in
use and re-clones them on a fresh machine.

`shell.json` (symlinked above) already lists which plugins are enabled and
where they sit in the bar, so once a plugin is cloned it shows up on the next
`omarchy restart shell`. The script also runs the plugin's own `install.sh
--enable --restart` when present, for plugins that patch `shell.json`
themselves on install.

Tracked plugins worth knowing about:

- `moorgrove.overview` ([omarchy-overview](https://github.com/itsmoorgrove/omarchy-overview)) —
  workspace overview with live window previews and a bar icon. Toggled with
  `SUPER + TAB` in `bindings.lua` (replaces Omarchy's default "Next workspace").
  Its settings sheet can't write a shortcut through the `bindings.lua` symlink,
  so keep the bind in `bindings.lua` by hand.

To add a plugin: install it normally (per its own instructions), confirm it
works, then add `[plugin-id]="<git-clone-url>"` to the `PLUGINS` array here.
The `plugin-id` must match the folder name it installs under (and the `id`
shell.json references for it).

## Secrets

`secrets-setup.sh` only creates an empty template at
`~/.config/secrets/env` (permissions `600`) if one doesn't already exist. The
real values are never committed to this repo — fill them in locally after
running the script. `.zshrc` sources this file automatically.

## nice tools

https://github.com/devmobasa/wayscriber
