if status is-interactive
    set fish_greeting
    set -g __fish_git_prompt_show_informative_status 1

    export EDITOR=vim
    export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'

    abbr -a weather "curl wttr.in"
    abbr -a d docker
    abbr -a dls "docker image ls --format='table {{.ID}}\t{{.Repository}}\t{{.Tag}}'"
    abbr -a dirm "docker image rm"

    if env | grep -q '^WSLENV='
        export DISPLAY=$(grep nameserver /etc/resolv.conf | awk '{print $2}'):0
        export LIBGL_ALWAYS_INDIRECT=1
    end
end
