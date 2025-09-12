#!/usr/bin/env fish

yay -Syu
uv tool update --all
fisher update
vim +PlugUpdate
