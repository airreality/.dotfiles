#!/usr/bin/env bash
set -e

log=/root/install_env.log
exec > $log 2>&1

# base packages
yum -y update
yum install -y epel-release centos-release-scl \
    wget tree the_silver_searcher tmux git zsh \
    make cmake ctags ncurses-devel devtoolset-6 
source /opt/rh/devtoolset-6/enable

# vim and python
( cd /tmp/ && git clone https://github.com/vim/vim && cd vim && \
    ./configure --with-features=huge \
                --enable-python3interp \
                --prefix=/usr && \
    make && make install
)
git clone https://github.com/VundleVim/Vundle.vim.git /root/.vim/bundle/Vundle.vim

if [[ $1 == '--lite' ]]; then
    curl -o /root/.vimrc https://raw.githubusercontent.com/airreality/.dotfiles/master/.vimrc_lite
    vim +PluginInstall +qall
else
    yum install -y python36 python36-devel
    curl -o /root/.vimrc https://raw.githubusercontent.com/airreality/.dotfiles/master/.vimrc
    vim +PluginInstall +qall
    ( cd /root/.vim/bundle/youcompleteme && python36 install.py --all )
fi

# zsh
curl -o /root/.bashrc https://raw.githubusercontent.com/airreality/.dotfiles/master/.bashrc
curl -o /root/.aliases https://raw.githubusercontent.com/airreality/.dotfiles/master/.aliases_test_servers
curl -Lo /root/install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
( export ZSH=/usr/share/oh-my-zsh && sh /root/install.sh --unattended )
curl -o /root/.zshrc https://raw.githubusercontent.com/airreality/.dotfiles/master/.zshrc
curl -o /usr/share/oh-my-zsh/themes/airreality.zsh-theme https://raw.githubusercontent.com/airreality/.dotfiles/master/.airreality.zsh-theme
git clone https://github.com/zsh-users/zsh-autosuggestions /usr/share/oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /usr/share/oh-my-zsh/plugins/zsh-syntax-highlighting
chsh -s $(which zsh)

updatedb
