local fn = vim.fn
local api = vim.api

local utils = require("utils")

local function augroup(name)
    return api.nvim_create_augroup(name, { clear = true })
end

-- highlight yanked text
local yank_group = augroup("highlight_yank")

api.nvim_create_autocmd({ "TextYankPost" }, {
    group = yank_group,
    callback = function()
        vim.highlight.on_yank({ higroup = "YankColor", timeout = 300 })
    end,
})

api.nvim_create_autocmd({ "CursorMoved" }, {
    group = yank_group,
    callback = function()
        vim.g.current_cursor_pos = vim.fn.getcurpos()
    end,
})

api.nvim_create_autocmd("TextYankPost", {
    group = yank_group,
    callback = function(_)
        if vim.v.event.operator == "y" then
            vim.fn.setpos(".", vim.g.current_cursor_pos)
        end
    end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup("last_loc"),
    callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
            return
        end
        vim.b[buf].last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- create dir when saving a file, if not exists
api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*",
    group = api.nvim_create_augroup("auto_create_dir", { clear = true }),
    callback = function(ctx)
        local dir = fn.fnamemodify(ctx.file, ":p:h")
        utils.mkdir(dir)
    end,
})

-- reload file if changed
-- It seems that `checktime` does not work in command line. We need to check if we are in command
-- line before executing this command, see also https://vi.stackexchange.com/a/20397/15292 .
api.nvim_create_augroup("auto_read", { clear = true })

api.nvim_create_autocmd({ "FileChangedShellPost" }, {
    pattern = "*",
    group = "auto_read",
    callback = function()
        vim.notify("File changed on disk. Buffer reloaded!", vim.log.levels.WARN, { title = "Buffer reloaded" })
    end,
})

api.nvim_create_autocmd({ "FocusGained", "CursorHold" }, {
    pattern = "*",
    group = "auto_read",
    callback = function()
        if fn.getcmdwintype() == "" then
            vim.cmd("checktime")
        end
    end,
})

-- resize all windows on terminal resizing
api.nvim_create_autocmd("VimResized", {
    group = api.nvim_create_augroup("win_autoresize", { clear = true }),
    desc = "autoresize windows on resizing operation",
    command = "wincmd =",
})
