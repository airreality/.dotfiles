local keymap = vim.keymap
local nvim_tree = require("nvim-tree")

nvim_tree.setup({
    auto_reload_on_write = true,
    disable_netrw = true,
    sort_by = "name",
    renderer = {
        icons = {
            webdev_colors = true,
        },
    },
})

keymap.set("n", "<leader>t", require("nvim-tree.api").tree.toggle, {
    silent = true,
    desc = "toggle nvim-tree",
})
