return {
    { "godlygeek/tabular", cmd = "Tabularize", ft = "markdown" },
    { "preservim/vim-markdown", ft = "markdown" },
    {
        "iamcco/markdown-preview.nvim",
        build = ":call mkdp#util#install()",
        ft = "markdown",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
}
