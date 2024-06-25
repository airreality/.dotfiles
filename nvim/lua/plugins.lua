return {
    { "nvim-tree/nvim-web-devicons", event = "VeryLazy" },
    {
        "liuchengxu/vista.vim",
        cmd = "Vista",
        event = "VeryLazy",
    },

    { "mbbill/undotree", cmd = { "UndotreeShow", "UndotreeToggle" } },
    { "stevearc/dressing.nvim" }, -- fzf, lsp-replacements UI improvements
    { "sbdchd/neoformat", cmd = "Neoformat" },
    { "tpope/vim-fugitive", event = "User GitRepoIn" },
    {
        "rbong/vim-flog",
        cmd = "Flog",
        dependencies = { "tpope/vim-fugitive" },
    },
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
