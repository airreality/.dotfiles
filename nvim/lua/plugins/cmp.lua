return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "onsails/lspkind-nvim",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-omni",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        {
            "garymjr/nvim-snippets",
            opts = { friendly_snippets = true },
            dependencies = { "rafamadriz/friendly-snippets" },
        },
    },
    opts = function()
        vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
        local cmp = require("cmp")
        return {
            completion = {
                keyword_length = 1,
                completeopt = "menu,menuone,noinsert",
            },
            experimental = {
                ghost_text = {
                    hl_group = "CmpGhostText",
                },
            },
            formatting = {
                format = require("lspkind").cmp_format({
                    mode = "symbol_text",
                    menu = {
                        nvim_lsp = "[LSP]",
                        luasnip = "[Snip]",
                        nvim_lua = "[Lua]",
                        path = "[Path]",
                        buffer = "[Buffer]",
                        omni = "[Omni]",
                    },
                }),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-j>"] = function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end,
                ["<C-k>"] = function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end,
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping.confirm({ select = true }),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
            }),
            sources = {
                { name = "nvim_lsp" },
                { name = "snippets" },
                { name = "path" },
                { name = "buffer", keyword_length = 2 },
                { name = "nvim_lsp_signature_help" },
            },
            view = {
                entries = "custom",
            },
        }
    end,
    config = function(_, opts)
        require("cmp").setup(opts)
    end,
}
