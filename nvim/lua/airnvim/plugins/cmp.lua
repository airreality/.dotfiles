return {
    "saghen/blink.cmp",
    version = "*",
    event = "InsertEnter",
    dependencies = {
        {
            "garymjr/nvim-snippets",
            opts = { friendly_snippets = true },
            dependencies = { "rafamadriz/friendly-snippets" },
        },
        "saghen/blink.compat",
    },
    opts = {
        keymap = {
            preset = "super-tab",
            ["<C-j>"] = { "select_next" },
            ["<C-k>"] = { "select_prev" },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono",
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
        completion = {
            accept = {
                auto_brackets = { enabled = false },
                create_undo_point = true,
            },
            menu = {
                winblend = vim.o.pumblend,
                draw = { treesitter = { "lsp" } },
            },
            ghost_text = {
                enabled = false,
            },
        },
        signature = { enabled = true },
    },
}
