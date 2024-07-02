return {
    { "tpope/vim-fugitive", event = "User GitRepoIn" },
    { "rbong/vim-flog", cmd = "Flog" },
    {
        "lewis6991/gitsigns.nvim",
        -- TODO: support 0.9.0 version
        lazy = false,
        version = "v0.8.1",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "│" },
            },
            word_diff = false,
            on_attach = function(_)
                vim.api.nvim_create_autocmd("ColorScheme", {
                    pattern = "*",
                    callback = function()
                        vim.api.nvim_set_hl(0, "GitSignsChangeInline", { gui = "reverse" })
                        vim.api.nvim_set_hl(0, "GitSignsAddInline", { gui = "reverse" })
                        vim.api.nvim_set_hl(0, "GitSignsDeleteInline", { gui = "reverse" })
                    end,
                })
            end,
        },
    },
}
