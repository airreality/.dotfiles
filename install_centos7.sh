#!/usr/bin/bash

log=/root/script.log
exec > $log 2>&1

yum install -y epel-release centos-release-scl
yum install -y wget curl tree tmux git mlocate setxkbmap
yum install -y vim neovim python36 python36-devel python36-neovim
yum install -y devtoolset-6 cmake && source /opt/rh/devtoolset-6/enable
source /opt/rh/devtoolset-6/enable
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
wget -O /root/.vimrc https://raw.githubusercontent.com/airreality/.dotfiles/master/.vimrc
wget -O /root/.bashrc https://raw.githubusercontent.com/airreality/.dotfiles/master/.bashrc
mkdir -p /root/.config/nvim/
ln -s /root/.vimrc /root/.config/nvim/init.vim
nvim +PluginInstall +qall
( cd /root/.vim/bundle/youcompleteme && python36 install.py --all )
updatedb
