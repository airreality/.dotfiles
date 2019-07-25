# AIRREALITY ZSH THEME
if [[ -z $SSH_CONNECTION ]]; then
    PROMPT_COLOR="green"
    PROMPT_IP=
else
    PROMPT_COLOR="magenta"
    PROMPT_IP=$(echo "$SSH_CONNECTION" | awk {'print $3 ":"'})
fi
PROMPT='%{$fg[$PROMPT_COLOR]%}${PROMPT_IP}%d%{$reset_color%} $FG[105]%(!.#.$)%{$reset_color%} '
RPROMPT='$(git_prompt_info)$(git_prompt_status)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[$PROMPT_COLOR]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[blue]%}✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[magenta]%}✭"
ZSH_THEME_GIT_PROMPT_DELETED=""
ZSH_THEME_GIT_PROMPT_RENAMED=""
ZSH_THEME_GIT_PROMPT_UNMERGED=""
ZSH_THEME_GIT_PROMPT_UNTRACKED=""
