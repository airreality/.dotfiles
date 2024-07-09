return {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "onsails/lspkind-nvim",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-omni",
        "saadparwaiz1/cmp_luasnip",
        {
            "garymjr/nvim-snippets",
            opts = { friendly_snippets = true },
            dependencies = { "rafamadriz/friendly-snippets" },
        },
    },
    keys = {
        {
            "<Tab>",
            function()
                return vim.snippet.active({ direction = 1 }) and "<cmd>lua vim.snippet.jump(1)<cr>" or "<Tab>"
            end,
            expr = true,
            silent = true,
            mode = { "i", "s" },
        },
        {
            "<S-Tab>",
            function()
                return vim.snippet.active({ direction = -1 }) and "<cmd>lua vim.snippet.jump(-1)<cr>" or "<S-Tab>"
            end,
            expr = true,
            silent = true,
            mode = { "i", "s" },
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
                        buffer = "[Buf]",
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
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
            }),
            sources = {
                { name = "nvim_lsp" },
                { name = "nvim_lsp_signature_help" },
                { name = "path" },
                { name = "snippets" },
                { name = "buffer", keyword_length = 2 },
            },
            view = {
                entries = "custom",
            },
        }
    end,
    config = function(_, opts)
        local cmp = require("cmp")
        cmp.setup(opts)
        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline({
                ["<C-n>"] = { c = cmp.mapping.select_next_item() },
                ["<C-p>"] = { c = cmp.mapping.select_prev_item() },
                ["<C-j>"] = { c = cmp.mapping.select_next_item() },
                ["<C-k>"] = { c = cmp.mapping.select_prev_item() },
                ["<Tab>"] = { c = cmp.mapping.confirm({ select = true }) },
            }),
            ---@diagnostic disable-next-line: undefined-field
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                {
                    name = "cmdline",
                    option = {
                        ignore_cmds = { "Man", "!" },
                    },
                },
            }),
        })
    end,
}
