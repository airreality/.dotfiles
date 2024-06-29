local fn = vim.fn

vim.g.logging_level = "info"

vim.g.loaded_perl_provider = 0 -- disable perl provider
vim.g.loaded_ruby_provider = 0 -- disable ruby provider
vim.g.loaded_node_provider = 0 -- disable node provider
vim.g.did_install_default_menus = 1 -- do not load menu

local python_executable_command = ""
if fn.exists("$VIRTUAL_ENV") == 1 then
    python_executable_command = "which -a python3 | head -n2 | tail -n1"
else
    python_executable_command = "which python3"
end

vim.g.python3_host_prog = fn.substitute(fn.system(python_executable_command), "\n", "", "g")
vim.g.mapleader = ","

-- highlight lua in vim script
vim.g.vimsyn_embed = "l"

vim.cmd([[language en_US.UTF-8]])

-- disable netrw

-- netrw is a standard neovim plugin that is enabled by default. It provides,
-- amongst other functionality, a file/directory browser.
-- It interferes with nvim-tree and the intended user experience is nvim-tree
-- replacing the netrw browser.

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_liststyle = 3

-- disable tohtml.vim
vim.g.loaded_2html_plugin = 1

-- disable plugins related to checking files inside compressed files
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1

-- disable tutor plugin
vim.g.loaded_tutor_mode_plugin = 1

vim.g.editorconfig = false
