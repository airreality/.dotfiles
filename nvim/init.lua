vim.loader.enable()

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("globals")
require("autocmd")
require("mappings")
require("options")

require("lazy").setup(
    "plugins",
    { ui = {
        border = "rounded",
        title = "Plugin Manager",
        title_pos = "center",
    } }
)

require("commands")
