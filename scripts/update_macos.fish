#!/usr/bin/env fish

brew update
brew upgrade
uv tool update --all
fisher update
vim +PlugUpdate
