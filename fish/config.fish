if status is-interactive
    set fish_greeting
    set -g __fish_git_prompt_show_informative_status 1

    function sync_history --on-event fish_preexec
        history --save
        history --merge
    end

    export BAT_THEME="ansi"
    export EDITOR=vim
    export FZF_DEFAULT_COMMAND="rg --color auto --files"
    export POETRY_CONFIG_DIR="~/.config/pypoetry"

    abbr -a weather "curl wttr.in"
    abbr -a d docker
    abbr -a dls "docker image ls --format='table {{.ID}}\t{{.Repository}}\t{{.Tag}}'"
    abbr -a dirm "docker image rm"
    abbr -a gpf "git push --force"
    abbr -a gb "git branch"
    abbr -a gbm "git branch -m"

    if env | grep -q "^WSLENV="
        export DISPLAY=$(grep nameserver /etc/resolv.conf | awk "{print $2}"):0
        export LIBGL_ALWAYS_INDIRECT=1
    else if [ $(uname) = "Darwin" ]
        eval "$(/opt/homebrew/bin/brew shellenv)"
        set PATH "/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
        set PATH "/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
    end

    pyenv init - | source
end
