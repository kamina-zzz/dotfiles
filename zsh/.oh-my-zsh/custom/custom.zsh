# [ghq]
function repo { cd $(ghq list -p | fzf -q ""$@"") }

function clone() {
  ghq get -p $@ && cd $(ghq list -p | grep $@);
}

function kclone() {
  clone kamina-zzz/$@;
}

# after cd command, execute ll
function cd() {
  builtin cd $@ && ll;
}

# load local settings
if [ -f ~/.local.zsh ]; then
	. ~/.local.zsh
fi
