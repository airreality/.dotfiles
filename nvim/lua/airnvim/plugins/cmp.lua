return {
    "saghen/blink.cmp",
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
        accept = {
            auto_brackets = { enabled = true },
            create_undo_point = true,
        },
        highligh = {
            use_nvim_cmp_as_default = true,
        },
        nerd_font_variant = "mono",
        trigger = {
            signature_help = { enabled = true },
        },
        windows = {
            autocomplete = {
                draw = "reversed",
            },
            ghost_text = {
                enabled = true,
            },
        },
    },
    sources = {
        completion = {
            enabled_providers = { "lsp", "path", "snippets", "buffer" },
        },
    },
}
