return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        plugins = { spelling = true },
        window = {
            margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
            padding = { 1, 0, 1, 0 }, -- extra window padding [top, right, bottom, left]
        },
    },
}
