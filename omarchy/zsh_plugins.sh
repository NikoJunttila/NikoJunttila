#!/usr/bin/env bash
set -euo pipefail

echo "==> Installing dependencies"
sudo pacman install -y git curl fzf

echo "==> Installing Oh My Zsh (if missing)"
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh already installed"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

echo "==> Installing zsh-autosuggestions"
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
  echo "zsh-autosuggestions already installed"
fi

echo "==> Installing zsh-syntax-highlighting"
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
  echo "zsh-syntax-highlighting already installed"
fi

cat <<'EOF'

Add this to your ~/.zshrc:

# Built into Oh My Zsh:
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
#
# External plugins:
# https://github.com/zsh-users/zsh-autosuggestions
# https://github.com/zsh-users/zsh-syntax-highlighting
#
# fzf is a separate tool installed from apt:
# https://github.com/junegunn/fzf

plugins=(
  git
  zsh-autosuggestions
  fzf
)

source $ZSH/oh-my-zsh.sh

# Load syntax highlighting last
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

EOF

echo "==> Done"
echo "Reload with: source ~/.zshrc"
