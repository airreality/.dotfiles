return {
    { "nvim-tree/nvim-web-devicons", lazy = true },
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        init = function()
            require("bqf")
        end,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
}
