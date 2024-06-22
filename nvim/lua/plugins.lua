return {
    {
        "rmehri01/onenord.nvim",
        lazy = false,
        priority = 52,
        init = function()
            require("onenord").setup({})
        end,
    },

    { "nvim-tree/nvim-web-devicons", event = "VeryLazy" },

    -- view code structure
    {
        "liuchengxu/vista.vim",
        cmd = "Vista",
        event = "VeryLazy",
    },

    -- lua autocomplete
    { "LuaLS/lua-language-server", ft = "lua" }, -- requires lua-language-server in system
    { "ii14/emmylua-nvim", ft = "lua" },

    { "Vimjas/vim-python-pep8-indent", ft = "python" },

    { "cespare/vim-toml", ft = "toml", branch = "main" },
    { "mbbill/undotree", cmd = { "UndotreeShow", "UndotreeToggle" } },
    { "stevearc/dressing.nvim" }, -- fzf, lsp-replacements UI improvements
    { "sbdchd/neoformat", cmd = "Neoformat" },

    { "tpope/vim-fugitive", event = "User GitRepoIn" },
    {
        "rbong/vim-flog",
        cmd = "Flog",
        dependencies = { "tpope/vim-fugitive" },
    },

    { "vim-test/vim-test", ft = "python" },

    -- quickfix window improvements
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        init = function()
            require("bqf")
        end,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },

    { "godlygeek/tabular", cmd = "Tabularize", ft = "markdown" },
    { "preservim/vim-markdown", ft = "markdown" },
    {
        "iamcco/markdown-preview.nvim",
        build = ":call mkdp#util#install()",
        ft = "markdown",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    { "wellle/targets.vim", event = "VeryLazy" },
    { "machakann/vim-sandwich", event = "VeryLazy" },
}
