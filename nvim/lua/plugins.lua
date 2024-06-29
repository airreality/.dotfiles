return {
    { "nvim-tree/nvim-web-devicons", event = "VeryLazy" },
    { "stevearc/dressing.nvim" }, -- fzf, lsp-replacements UI improvements
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        init = function()
            require("bqf")
        end,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
}
