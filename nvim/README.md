# Neovim Config

NvChad v2.5 based configuration. NvChad core lives in `~/.local/share/nvim/lazy/NvChad/`.

## Prerequisites

- Neovim >= 0.12
- A C compiler (`gcc` or `clang`) for tree-sitter parser compilation
- `tree-sitter-cli` for building parsers (required by the `main` branch of nvim-treesitter)

## Install system dependencies

### Arch Linux

```sh
sudo pacman -S neovim tree-sitter-cli gcc mermaid-cli
```

### Ubuntu / Debian

```sh
npm install -g tree-sitter-cli
```

## Setup

Clone this repo to your nvim config directory and open Neovim. Lazy.nvim will bootstrap itself and install all plugins automatically. Mason will install LSP servers and formatters on first launch.

```sh
git clone <repo-url> ~/.config/nvim
nvim
```

## AI Autocomplete (Neocodeium)

Authenticate after first launch:

```
:Neocodeium auth
```

Keybinds:

| Key       | Action                        |
| --------- | ----------------------------- |
| `<A-e>`   | Start AI / cycle suggestions  |
| `<A-f>`   | Accept suggestion             |

## Mermaid Charts

Requires `mermaid-cli` (`mmdc`). On Arch this is available via pacman. On Ubuntu, install via npm:

```sh
npm install -g @mermaid-js/mermaid-cli
```
