require("yanky").setup({
    ring = {
        history_length = 20,
        storage = "memory",
    },
    preserve_cursor_position = {
        enabled = false,
    },
})

-- cycle through the yank history after paste
vim.keymap.set("n", "<leader>]", "<Plug>(YankyCycleForward)")
vim.keymap.set("n", "<leader>[", "<Plug>(YankyCycleBackward)")
