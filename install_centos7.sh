#!/usr/bin/bash

log=/root/script.log
exec > $log 2>&1

# install
yum install -y epel-release centos-release-scl
yum install -y wget tree tmux git mlocate setxkbmap zsh
yum install -y vim neovim python36 python36-devel python36-neovim
yum install -y make cmake ncurses-devel devtoolset-6
source /opt/rh/devtoolset-6/enable

# vim
( cd /opt/ && git clone https://github.com/vim/vim && cd vim && \
    ./configure --with-features=huge \
                --enable-python3interp \
                --prefix=/usr && \
    make && make install
)
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
curl -o /root/.vimrc https://raw.githubusercontent.com/airreality/.dotfiles/master/.vimrc
mkdir -p /root/.config/nvim/
ln -s /root/.vimrc /root/.config/nvim/init.vim
vim +PluginInstall +qall
( cd /root/.vim/bundle/youcompleteme && python36 install.py --all )

# zsh
curl -o /root/.bashrc https://raw.githubusercontent.com/airreality/.dotfiles/master/.bashrc
curl -Lo /root/install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
( export ZSH=/usr/share/oh-my-zsh && sh /root/install.sh --unattended )
curl -o /root/.zshrc https://raw.githubusercontent.com/airreality/.dotfiles/master/.zshrc
curl -o /usr/share/oh-my-zsh/themes/airreality.zsh-theme https://raw.githubusercontent.com/airreality/.dotfiles/master/.airreality.zsh-theme
git clone https://github.com/zsh-users/zsh-autosuggestions /usr/share/oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /usr/share/oh-my-zsh/plugins/zsh-syntax-highlighting

updatedb
