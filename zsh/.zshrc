export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 13
COMPLETION_WAITING_DOTS="true"

plugins=(git fzf mise)

source $ZSH/oh-my-zsh.sh

# User configuration

export EDITOR=vim
export LANG=ja_JP.UTF-8
PATH=$PATH:$HOME/bin
