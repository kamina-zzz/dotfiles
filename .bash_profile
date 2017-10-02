# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# adapt local definitions
if [ -f ~/.local.bash ]; then
	. ~/.local.bash
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

if [ -d ~/.rbenv ]; then
    export PATH
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

if [ -d ~/.pyenv ]; then
    export PATH
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
fi

# Display Git Branch name
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\e[38;5;110m\]\u@\h\e[38;5;252m\]:\e[38;5;150m\]\w\e[38;5;216m\]$(__git_ps1 " (%s)")\e[38;5;252m\]\n\$ '

# Color Settings
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
