local utils = require("utils")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugin_specs = {
    {
        "rmehri01/onenord.nvim",
        lazy = false,
        priority = 52,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("config.treesitter")
        end,
        priority = 51,
    },

    { "nvim-tree/nvim-web-devicons", event = "VeryLazy" },

    -- view code structure
    {
        "liuchengxu/vista.vim",
        cmd = "Vista",
        event = "VeryLazy",
    },

    -- show match number and index for searching
    {
        "kevinhwang91/nvim-hlslens",
        branch = "main",
        keys = { "*", "#", "n", "N" },
        config = function()
            require("config.hlslens")
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        main = "ibl",
        config = function()
            require("config.indent-blankline")
        end,
    },

    -- cmdline autocomplete
    {
        "gelguy/wilder.nvim",
        build = ":UpdateRemotePlugins",
    },

    -- lua autocomplete
    -- requires lua-language-server in system
    { "LuaLS/lua-language-server", ft = "lua" },
    { "ii14/emmylua-nvim", ft = "lua" },

    { "Vimjas/vim-python-pep8-indent", ft = { "python" } },
    { "jeetsukumaran/vim-pythonsense", ft = { "python" } }, -- python text objects and motions

    { "cespare/vim-toml", ft = { "toml" }, branch = "main" },
    { "machakann/vim-swap", event = "VeryLazy" }, -- swap args keymaps
    { "Raimondi/delimitMate", event = "InsertEnter" }, -- auto-complete brackets, quotes, etc
    { "tpope/vim-commentary", event = "VeryLazy" },
    { "mbbill/undotree", cmd = { "UndotreeShow", "UndotreeToggle" } },
    { "stevearc/dressing.nvim" }, -- fzf, lsp-replacements UI improvements
    { "nvim-zh/better-escape.vim", event = { "InsertEnter" } },
    { "sbdchd/neoformat", cmd = { "Neoformat" } },

    { "tpope/vim-fugitive", event = "User InGitRepo" },
    {
        "rbong/vim-flog",
        cmd = { "Flog" },
        dependencies = {
            "tpope/vim-fugitive",
        },
    },

    -- show git signs for changes
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("config.gitsigns")
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
            require("config.lualine")
        end,
    },

    -- autocomplete
    {
        "hrsh7th/nvim-cmp",
        event = "VeryLazy",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "onsails/lspkind-nvim",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-omni",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            require("config.nvim-cmp")
        end,
    },

    {
        "zbirenbaum/copilot.lua",
        enabled = function()
            return utils.executable("node")
        end,
        ft = { "python" },
        cmd = "Copilot",
        build = ":Copilot auth",
        config = function()
            require("config.copilot")
        end,
    },

    {
        "CopilotC-Nvim/CopilotChat.nvim",
        enabled = function()
            return utils.executable("node")
        end,
        ft = { "python" },
        cmd = "CopilotChatToggle",
        branch = "canary",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim" },
        },
        config = function()
            require("config.copilotchat")
        end,
    },

    {
        "neovim/nvim-lspconfig",
        event = { "BufRead", "BufNewFile" },
        config = function()
            require("config.lsp")
        end,
    },

    -- lsp progress UI
    {
        "j-hui/fidget.nvim",
        event = "VeryLazy",
        config = function()
            require("config.fidget")
        end,
    },

    {
        "vim-test/vim-test",
        ft = { "python" },
    },

    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        config = function()
            require("config.notify")
        end,
    },

    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("config.fzf")
        end,
    },

    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        event = "VeryLazy",
        config = function()
            vim.api.nvim_set_keymap("i", "<C-j>", "<Plug>luasnip-expand-or-jump", { desc = "Expand snip or jump next" })
            vim.api.nvim_set_keymap("s", "<C-j>", "<Plug>luasnip-expand-or-jump", { desc = "Expand snip or jump next" })
            vim.api.nvim_set_keymap("i", "<C-k>", "<Plug>luasnip-jump-prev", { desc = "Jump previous snip item" })
            vim.api.nvim_set_keymap("s", "<C-k>", "<Plug>luasnip-jump-prev", { desc = "Jump previous snip item" })
            require("luasnip").config.setup({
                history = true,
                update_events = "TextChanged, TextChangedI",
            })
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },

    {
        "gbprod/yanky.nvim",
        cmd = { "YankyRingHistory" },
        config = function()
            require("config.yanky")
        end,
    },

    -- quickfix window improvements
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        config = function()
            require("config.bqf")
        end,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },

    {
        "godlygeek/tabular",
        cmd = { "Tabularize" },
        ft = { "markdown" },
    },
    { "preservim/vim-markdown", ft = { "markdown" } },
    {
        "iamcco/markdown-preview.nvim",
        build = ":call mkdp#util#install()",
        ft = { "markdown" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    { "wellle/targets.vim", event = "VeryLazy" },
    { "machakann/vim-sandwich", event = "VeryLazy" },

    -- debugger
    -- TODO research
    {
        "sakhnik/nvim-gdb",
        event = "VeryLazy",
        build = { "bash install.sh" },
    },

    -- show keybindings
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("config.which-key")
        end,
    },

    {
        "nvim-tree/nvim-tree.lua",
        keys = { "<leader>t" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("config.tree")
        end,
    },
}
local lazy_opts = {
    ui = {
        border = "rounded",
        title = "Plugin Manager",
        title_pos = "center",
    },
}

require("lazy").setup(plugin_specs, lazy_opts)
