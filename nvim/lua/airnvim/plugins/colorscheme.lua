return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = { style = "moon" },
    config = function()
        local tokyonight = require("tokyonight")
        tokyonight.setup({
            on_highlights = function(hl, c)
                hl.YankColor = { bg = c.green, fg = c.bg_dark }
            end,
        })
        tokyonight.load()
    end,
}
