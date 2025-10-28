# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="kamina"
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 13
COMPLETION_WAITING_DOTS="true"

plugins=(git fzf mise gcloud kubectl kubectx)

source $ZSH/oh-my-zsh.sh

# User configuration

export EDITOR=vim
export LANG=ja_JP.UTF-8
PATH=$PATH:$HOME/bin
