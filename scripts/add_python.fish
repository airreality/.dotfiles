#!/usr/bin/env fish

set -l python_version {$argv[1]}
pyenv install {$python_version}
~/.pyenv/versions/{$python_version}/bin/python -m pip install -U \
    jedi \
    mypy \
    pylsp-mypy \
    pynvim \
    python-lsp-server \
    ruff
