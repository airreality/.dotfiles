return {
    "saghen/blink.cmp",
    version = "*",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        {
            "garymjr/nvim-snippets",
            opts = { friendly_snippets = true },
            dependencies = { "rafamadriz/friendly-snippets" },
        },
        "saghen/blink.compat",
        "xzbdmw/colorful-menu.nvim",
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
                draw = {
                    treesitter = { "lsp" },
                    columns = { { "kind_icon" }, { "label", gap = 1 } },
                    components = {
                        label = {
                            text = function(ctx)
                                return require("colorful-menu").blink_components_text(ctx)
                            end,
                            highlight = function(ctx)
                                return require("colorful-menu").blink_components_highlight(ctx)
                            end,
                        },
                    },
                },
            },
            ghost_text = {
                enabled = true,
            },
        },
        signature = { enabled = true },
        cmdline = {
            enabled = true,
            completion = {
                ghost_text = { enabled = true },
                list = { selection = { preselect = false } },
                menu = { auto_show = true },
            },
            keymap = { preset = "inherit" },
        },
    },
}
