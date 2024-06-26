return {
    { "nvim-tree/nvim-web-devicons", event = "VeryLazy" },
    { "mbbill/undotree", cmd = { "UndotreeShow", "UndotreeToggle" } },
    { "stevearc/dressing.nvim" }, -- fzf, lsp-replacements UI improvements
    { "sbdchd/neoformat", cmd = "Neoformat" },
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        init = function()
            require("bqf")
        end,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    { "wellle/targets.vim", event = "VeryLazy" },
}
