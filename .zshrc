ZSH=/usr/share/oh-my-zsh
ZSH_THEME=airreality
DISABLE_AUTO_UPDATE="true"
plugins=(
    colored-man-pages
    copybuffer
    docker
    git
    sudo
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

[[ -f ~/.aliases ]] && . ~/.aliases
[[ -f ~/.aliases_docker ]] && . ~/.aliases_docker
[[ -f ~/.aliases_hidden ]] && . ~/.aliases_hidden
[[ -f /usr/share/fzf/key-bindings.zsh ]] && . /usr/share/fzf/key-bindings.zsh
[[ -f /usr/share/fzf/completion.zsh ]] && . /usr/share/fzf/completion.zsh

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

zstyle ':completion:*' hosts off

export EDITOR=vim
export TERM=xterm-256color
export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
