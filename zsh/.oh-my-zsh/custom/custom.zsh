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
alias cl='claude --enable-auto-mode'

alias vi='nvim'
alias vim='nvim'
alias v='nvim'

# FUNCTIONS

## after cd command, execute l
function cd() {
  builtin cd $@ && l;
}

## [gwq]
function clf() {
  local branch="feat/$@"
  if gwq get "$branch" &>/dev/null; then
    : # worktree already exists
  elif git show-ref --verify --quiet "refs/heads/$branch"; then
    gwq add "$branch"
  else
    gwq add -b "$branch"
  fi
  gwq cd "$branch" && claude
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

# COMPLETION

## [gwq]
source <(gwq completion zsh)

# status line
eval "$(starship init zsh)"

# load local settings
if [ -f ~/.local.zsh ]; then
	. ~/.local.zsh
fi
