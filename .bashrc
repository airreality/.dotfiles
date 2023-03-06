[[ $- != *i* ]] && return

colors() {
    local fgc bgc vals seq0

    printf "Color escapes are %s\n" '\e[${value};...;${value}m'
    printf "Values 30..37 are \e[33mforeground colors\e[m\n"
    printf "Values 40..47 are \e[43mbackground colors\e[m\n"
    printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

    # foreground colors
    for fgc in {30..37}; do
        # background colors
        for bgc in {40..47}; do
            fgc=${fgc#37} # white
            bgc=${bgc#40} # black

            vals="${fgc:+$fgc;}${bgc}"
            vals=${vals%%;}

            seq0="${vals:+\e[${vals}m}"
            printf "  %-9s" "${seq0:-(default)}"
            printf " ${seq0}TEXT\e[m"
            printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
        done
        echo; echo
    done
}

export http_proxy=""
export https_proxy=""
export ftp_proxy=""
export socks_proxy=""

[[ -f ~/.aliases ]] && . ~/.aliases
[[ -f ~/.aliases_docker ]] && . ~/.aliases_docker
[[ -f ~/.aliases_hidden ]] && . ~/.aliases_hidden

export BAT_THEME="ansi"
export EDITOR=vim
export HISTTIMEFORMAT="%d-%m-%y %T    "
export FZF_DEFAULT_COMMAND="rg --color auto --files"
export POETRY_CONFIG_DIR="~/.config/pypoetry"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
if [ $(uname) = "Darwin" ]; then
    export FZF_BASE="/opt/homebrew/opt/fzf"
fi
