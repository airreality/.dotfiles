require("yanky").setup({
    ring = {
        history_length = 10,
        storage = "memory",
    },
    highlight = {
        on_put = false,
        on_yank = false,
    },
    preserve_cursor_position = {
        enabled = false,
    },
})
