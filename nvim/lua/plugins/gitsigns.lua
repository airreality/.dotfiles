return {
    "lewis6991/gitsigns.nvim",
    -- TODO: support 0.9.0 version
    version="v0.8.1",
    opts = {
        signs = {
            add = { hl = "GitSignsAdd", text = "+", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
            change = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
            delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
            topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
            changedelete = {
                hl = "GitSignsChange",
                text = "│",
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn",
            },
        },
        word_diff = false,
        on_attach = function(buffer)
            local gs = package.loaded["gitsigns"]

            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = "*",
                callback = function()
                    vim.api.nvim_set_hl(0, "GitSignsChangeInline", { gui = "reverse" })
                    vim.api.nvim_set_hl(0, "GitSignsAddInline", { gui = "reverse" })
                    vim.api.nvim_set_hl(0, "GitSignsDeleteInline", { gui = "reverse" })
                end,
            })

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = buffer
                vim.keymap.set(mode, l, r, opts)
            end

            map("n", "]c", function()
                if vim.wo.diff then
                    return "]c"
                end
                vim.schedule(function()
                    gs.next_hunk()
                end)
                return "<Ignore>"
            end, { expr = true, desc = "next hunk" })

            map("n", "[c", function()
                if vim.wo.diff then
                    return "[c"
                end
                vim.schedule(function()
                    gs.prev_hunk()
                end)
                return "<Ignore>"
            end, { expr = true, desc = "previous hunk" })
        end,
    },
}
