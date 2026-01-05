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

require("airnvim/globals")
require("airnvim/autocmd")
require("airnvim/mappings")
require("airnvim/options")

require("lazy").setup("airnvim/plugins", {
    rocks = {
        enabled = false,
    },
    ui = {
        border = "rounded",
        title = "Plugin Manager",
        title_pos = "center",
    },
})

require("airnvim/commands")
