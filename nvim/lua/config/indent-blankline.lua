local api = vim.api

local exclude_ft = { "help", "git", "markdown", "text" }

require("ibl").setup({
    indent = {
        char = "▏",
    },
    scope = {
        show_start = false,
        show_end = false,
    },
    exclude = {
        filetypes = exclude_ft,
        buftypes = { "terminal" },
    },
})

local gid = api.nvim_create_augroup("indent_blankline", { clear = true })
api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    group = gid,
    command = "IBLDisable",
})

api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    group = gid,
    callback = function()
        if not vim.tbl_contains(exclude_ft, vim.bo.filetype) then
            vim.cmd([[IBLEnable]])
        end
    end,
})
