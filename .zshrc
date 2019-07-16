ZSH=/usr/share/oh-my-zsh
ZSH_THEME=airreality
DISABLE_AUTO_UPDATE="true"
plugins=(
    colored-man-pages
    git
    sudo
    zsh-autosuggestions
    zsh-syntax-highlighting
    )

source $ZSH/oh-my-zsh.sh

[[ -f ~/.aliases ]] && . ~/.aliases

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

zstyle ':completion:*' hosts off

export EDITOR=nvim
