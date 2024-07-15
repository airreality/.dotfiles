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
    },
}
