status is-interactive || exit

set fish_greeting
set -g __fish_git_prompt_show_informative_status 1
set -g hydro_color_pwd "green"

function sync_history --on-event fish_preexec
    history --save
    history --merge
end

set -x BAT_THEME "ansi"
set -x EDITOR nvim
set -x TERM xterm-256color  # to avoid wezterm "WARNING: terminal is not fully functional"
set -x FZF_DEFAULT_COMMAND "rg --color auto --files"

abbr -a vim "nvim"
abbr -a weather "curl wttr.in"
abbr -a d docker
abbr -a dls "docker image ls --format='table {{.ID}}\t{{.Repository}}\t{{.Tag}}'"
abbr -a dirm "docker image rm"
abbr -a gpf "git push --force"
abbr -a gb "git branch"
abbr -a gbr "git branch --remotes"
abbr -a gbm "git branch -m"
abbr -a rc "ruff check --output-format=concise"
abbr -a rf "ruff format"
abbr -a mp "mypy --install-types --non-interactive ."

if env | grep -q "^WSLENV="
    set -x DISPLAY $(grep nameserver /etc/resolv.conf | awk '{print $2}'):0
    set -x LIBGL_ALWAYS_INDIRECT 1
else if [ $(uname) = "Darwin" ]
    eval "$(/opt/homebrew/bin/brew shellenv)"
    set -x PATH "/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
    set -x PATH "/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
end

pyenv init - | source
