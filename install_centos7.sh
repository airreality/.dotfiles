#!/usr/bin/env bash
set -e

log=/root/install_env.log
exec > $log 2>&1

# base packages
yum -y update
yum -y install epel-release
yum -y install which wget curl tree the_silver_searcher tmux git zsh \
    make cmake gcc-c++ ctags ncurses-devel

if [[ $1 != '--lite' ]]; then
    yum -y install python36-devel
fi

# fzf
( cd /tmp && git clone --depth 1 https://github.com/junegunn/fzf.git && \
    cd fzf && ./install )

# vim
( cd /tmp/ && git clone https://github.com/vim/vim && cd vim && \
    ./configure --with-features=huge \
                --enable-python3interp \
                --prefix=/usr && \
    make && make install )
git clone https://github.com/VundleVim/Vundle.vim.git /root/.vim/bundle/Vundle.vim

if [[ $1 == '--lite' ]]; then
    curl -o /root/.vimrc https://raw.githubusercontent.com/airreality/.dotfiles/master/.vimrc_lite
    vim +PluginInstall +qall
else
    curl -o /root/.vimrc https://raw.githubusercontent.com/airreality/.dotfiles/master/.vimrc
    vim +PluginInstall +qall
    ( cd /root/.vim/bundle/youcompleteme && python3 install.py )
fi

# zsh
curl -o /root/.bashrc https://raw.githubusercontent.com/airreality/.dotfiles/master/.bashrc
curl -o /root/.aliases https://raw.githubusercontent.com/airreality/.dotfiles/master/.aliases_test_servers
curl -Lo /tmp/install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
( export ZSH=/usr/share/oh-my-zsh && sh /tmp/install.sh --unattended )
curl -o /root/.zshrc https://raw.githubusercontent.com/airreality/.dotfiles/master/.zshrc
curl -o /usr/share/oh-my-zsh/themes/airreality.zsh-theme https://raw.githubusercontent.com/airreality/.dotfiles/master/.airreality.zsh-theme
git clone https://github.com/zsh-users/zsh-autosuggestions /usr/share/oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /usr/share/oh-my-zsh/plugins/zsh-syntax-highlighting
chsh -s $(which zsh)
