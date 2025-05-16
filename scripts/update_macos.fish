#!/usr/bin/env fish

brew update
brew upgrade
for tool in mypy ruff vulture python-lsp-server
    echo "Update $tool"
    uv tool update $tool
end
fisher update
vim +PlugUpdate
