# 🐱 Kitty welcome function
# kitty_welcome() {
#     (
#         echo "┌────────────────────────────┐"
#         echo "│   Welcome to Kitty! 🐱     │"
#         echo "│  Stay productive, stay 🧠  │"
#         echo "└────────────────────────────┘"
#     ) | lolcat
#         if command -v fastfetch >/dev/null; then
#         fastfetch --config ~/.config/fastfetch/config.jsonc
#     fi
# }

# 🚀 Run welcome only in Kitty terminal
# only add the hook if running in Kitty and it's an interactive shell
if [[ "$TERM" == "xterm-kitty" ]]; then
    kitty_welcome
fi
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions)

export VISUAL="nvim"
export EDITOR="nvim"

source $ZSH/oh-my-zsh.sh

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

chpwd() {
  ls
}

export PATH="$HOME/.local/kitty.app/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
alias vim='nvim'
alias ls='eza --icons --group-directories-first --color=auto'
alias grep='rg'
alias lol='fortune | cowsay -f stegosaurus | lolcat'
alias matrix='cmatrix'
alias python='python3'
alias t='task'
alias or='odin run .'
alias cd='z'
alias cat='batcat'
alias gs='git status'
source ~/powerlevel10k/powerlevel10k.zsh-theme

eval "$(zoxide init zsh)"
eval "$(task --completion zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="/usr/lib/llvm-20/bin:$PATH"
export PATH="/home/it-niko-lpt/Odin:$PATH"
export PATH="/home/it-niko-lpt/.terragrunt/bin:$PATH"

export GROQ_API_KEY=
