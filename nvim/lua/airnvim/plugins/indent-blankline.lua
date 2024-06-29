local exclude_filetypes = {
    "help",
    "git",
    "neo-tree",
    "lazy",
    "notify",
}

return {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    init = function()
        local ibl_toggle_group = vim.api.nvim_create_augroup("ibl_toggle", { clear = true })
        vim.api.nvim_create_autocmd("InsertEnter", {
            group = ibl_toggle_group,
            command = "IBLDisable",
        })

        vim.api.nvim_create_autocmd("InsertLeave", {
            group = ibl_toggle_group,
            callback = function()
                if not vim.tbl_contains(exclude_filetypes, vim.bo.filetype) then
                    vim.cmd([[IBLEnable]])
                end
            end,
        })
    end,
    opts = {
        indent = {
            char = "▏",
            tab_char = "▏",
        },
        scope = {
            show_start = false,
            show_end = false,
        },
        exclude = {
            filetypes = exclude_filetypes,
            buftypes = { "terminal" },
        },
    },
}
