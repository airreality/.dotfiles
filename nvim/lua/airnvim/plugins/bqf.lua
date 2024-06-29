return {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    init = function()
        require("bqf")
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
}
