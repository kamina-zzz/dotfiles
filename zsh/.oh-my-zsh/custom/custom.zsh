# ENV
## [GKE]
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# PATH
## [opencode]
export PATH=$HOME/.opencode/bin:$PATH

# ALIASES
unalias gg
unalias gga
alias gg='git grep -in --break'
alias gps='git push origin HEAD'

alias c='cursor .'
alias cl='claude'

# FUNCTIONS

## after cd command, execute l
function cd() {
  builtin cd $@ && l;
}

## [ghq]
function repo() {
  cd $(ghq list -p | fzf -q ""$@"")
}

function clone() {
  ghq get -p $@ && cd $(ghq list -p | grep $@);
}

function kclone() {
  clone kamina-zzz/$@;
}

# status line
eval "$(starship init zsh)"

# load local settings
if [ -f ~/.local.zsh ]; then
	. ~/.local.zsh
fi
