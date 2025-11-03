PROMPT='$FG[006][%n %D{%m/%d %T}]%f '
PROMPT2='$FG[006]_> %f'
RPROMPT='$FG[000][%~] $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[008]%}(%{$FG[003]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[008]%}) %{$FG[001]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[008]%})"
