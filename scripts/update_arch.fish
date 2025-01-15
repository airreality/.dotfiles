#!/usr/bin/env fish

yay -Syu
for tool in mypy ruff python-lsp-server
    echo "Update $tool"
    uv tool update $tool
end
fisher update
vim +PlugUpdate
