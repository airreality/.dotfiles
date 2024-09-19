return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            require("lazy").load({ plugins = { "markdown-preview.nvim" } })
            vim.fn["mkdp#util#install"]()
        end,
        config = function()
            vim.g.mkdp_auto_close = 0
        end,
    },
    {
        "lukas-reineke/headlines.nvim",
        ft = { "markdown" },
        dependencies = "nvim-treesitter/nvim-treesitter",
        opts = {
            markdown = {
                bullets = {},
            },
        },
    },
}
