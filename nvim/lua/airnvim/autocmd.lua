local function augroup(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end

local number_toggle_group = augroup("number_toggle")

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
    group = number_toggle_group,
    desc = "Toggle on line numbers",
    callback = function()
        if vim.opt_local.number then
            vim.opt_local.relativenumber = true
        end
    end,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
    group = number_toggle_group,
    desc = "Toggle off line numbers",
    callback = function()
        if vim.opt_local.number then
            vim.opt_local.relativenumber = false
        end
    end,
})

-- highlight yanked text

local highlight_yank_group = augroup("highlight_yank")

vim.api.nvim_create_autocmd("TextYankPost", {
    group = highlight_yank_group,
    callback = function()
        vim.highlight.on_yank({ higroup = "YankColor", timeout = 300 })
    end,
})

vim.api.nvim_create_autocmd("CursorMoved", {
    group = highlight_yank_group,
    callback = function()
        vim.g.current_cursor_pos = vim.fn.getcurpos()
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = highlight_yank_group,
    callback = function()
        if vim.v.event.operator == "y" then
            vim.fn.setpos(".", vim.g.current_cursor_pos)
        end
    end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup("open_last_position"),
    desc = "Go to last position when opening a buffer",
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

vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup("auto_create_dir"),
    desc = "Create dir if not exists on file saving",
    callback = function(event)
        if event.match:match("^%w%w+:[\\/][\\/]") then
            return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- reload file if changed
-- It seems that `checktime` does not work in command line. We need to check if we are in command
-- line before executing this command, see also https://vi.stackexchange.com/a/20397/15292 .
local auto_reload_group = augroup("auto_reload_group")

vim.api.nvim_create_autocmd("FileChangedShellPost", {
    group = auto_reload_group,
    callback = function()
        vim.notify("File changed on disk", vim.log.levels.WARN, { title = "Buffer reloaded" })
    end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "CursorHold" }, {
    group = auto_reload_group,
    callback = function()
        if vim.fn.getcmdwintype() == "" then
            vim.cmd("checktime")
        end
    end,
})

vim.api.nvim_create_autocmd("VimResized", {
    group = augroup("auto_resize_tabs"),
    desc = "Resize all tabs on vim resizing",
    command = "wincmd =",
})

local disable_cmd_smartcase_group = augroup("disable_cmd_smartcase_group")

vim.api.nvim_create_autocmd("CmdlineEnter", {
    group = disable_cmd_smartcase_group,
    desc = "Disable smartcase in cmd line mode",
    command = "set nosmartcase",
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
    group = disable_cmd_smartcase_group,
    desc = "Disable smartcase in cmd line mode",
    command = "set smartcase",
})

vim.api.nvim_create_autocmd("TermOpen", {
    group = augroup("disable_term_numbers"),
    desc = "Disable numbers in terminal",
    command = "setlocal norelativenumber nonumber",
})

vim.api.nvim_create_autocmd("TermOpen", {
    group = augroup("open_term_in_insert_mode"),
    desc = "Open terminal in insert mode",
    command = "startinsert",
})

vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
    group = augroup("check_is_git_repo"),
    desc = "Trigger custom event if in git repo",
    callback = function()
        local output = vim.fn.system({ "git", "rev-parse", "--is-inside-work-tree" })
        if string.match(output, "true") then
            vim.api.nvim_command("doautocmd User GitRepoIn")
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    group = augroup("check_is_dockerfile"),
    desc = "Set Dockerfile filetype",
    pattern = "Dockerfile*",
    callback = function()
        vim.opt_local.filetype = "dockerfile"
    end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
    group = augroup("set_custom_colors"),
    desc = "Set custom colors",
    callback = function()
        vim.api.nvim_set_hl(0, "YankColor", { ctermfg = 59, ctermbg = 41, fg = "#34495E", bg = "#8EBD6B" })
        vim.api.nvim_set_hl(0, "Cursor", { cterm = { bold = true }, bold = true, bg = "#8EBD6B", fg = "#34495E" })
        vim.api.nvim_set_hl(0, "Cursor2", { fg = "#E55561", bg = "#E55561" })
        vim.api.nvim_set_hl(0, "FloatBorder", { fg = "LightGreen", bg = "NONE" })
        vim.api.nvim_set_hl(
            0,
            "MatchParen",
            { cterm = { bold = true, underline = true }, bold = true, underline = true }
        )
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#A3BE8C" })
        vim.api.nvim_set_hl(0, "CmpGhostText", { fg = "#6C7A96" })
    end,
})

vim.filetype.add({
    pattern = {
        [".*"] = {
            function(path, buf)
                local large_file_size = 1 * 1024 * 1024 -- 1MB
                return vim.bo[buf]
                        and vim.bo[buf].filetype ~= "bigfile"
                        and path
                        and vim.fn.getfsize(path) > large_file_size
                        and "bigfile"
                    or nil
            end,
        },
    },
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    group = vim.api.nvim_create_augroup("handle_large_file", { clear = true }),
    pattern = "bigfile",
    callback = function(ev)
        local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(ev.buf), ":p:~:.")
        vim.notify(("Big file detected: `%s`"):format(path), vim.log.levels.INFO, { title = "Big File" })

        vim.api.nvim_set_option_value("relativenumber", false, { scope = "local" })
        vim.api.nvim_set_option_value("swapfile", false, { scope = "local" })
        vim.api.nvim_set_option_value("bufhidden", "unload", { scope = "local" })
        vim.api.nvim_set_option_value("buftype", "nowrite", { scope = "local" })
        vim.api.nvim_set_option_value("undolevels", -1, { scope = "local" })
    end,
})
