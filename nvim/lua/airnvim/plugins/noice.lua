return {
    "folke/noice.nvim",
    event = "VeryLazy",
    version="4.4.7",
    opts = {
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        cmdline = {
            view = "cmdline",
        },
    },
    config = function(_, opts)
        require("noice").setup(opts)
    end,
}
