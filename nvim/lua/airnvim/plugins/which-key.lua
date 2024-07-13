return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Show buffer mappings",
        },
    },
    opts = {
        icons = { rules = false },
        window = {
            margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
            padding = { 1, 0, 1, 0 }, -- extra window padding [top, right, bottom, left]
        },
    },
}
