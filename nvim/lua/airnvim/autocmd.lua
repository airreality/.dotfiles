local api = vim.api

local function augroup(name)
    return api.nvim_create_augroup(name, { clear = true })
end

local number_toggle_group = augroup("number_toggle")

api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
    group = number_toggle_group,
    desc = "Toggle on line numbers",
    callback = function()
        if vim.opt_local.number then
            vim.opt_local.relativenumber = true
        end
    end,
})
api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
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

api.nvim_create_autocmd("TextYankPost", {
    group = highlight_yank_group,
    callback = function()
        vim.highlight.on_yank({ higroup = "YankColor", timeout = 300 })
    end,
})

api.nvim_create_autocmd("CursorMoved", {
    group = highlight_yank_group,
    callback = function()
        vim.g.current_cursor_pos = vim.fn.getcurpos()
    end,
})

api.nvim_create_autocmd("TextYankPost", {
    group = highlight_yank_group,
    callback = function()
        if vim.v.event.operator == "y" then
            vim.fn.setpos(".", vim.g.current_cursor_pos)
        end
    end,
})

api.nvim_create_autocmd("BufReadPost", {
    group = augroup("open_last_position"),
    desc = "Go to last position when opening a buffer",
    callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
            return
        end
        vim.b[buf].last_loc = true
        local mark = api.nvim_buf_get_mark(buf, '"')
        local lcount = api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

api.nvim_create_autocmd("BufWritePre", {
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

api.nvim_create_autocmd("FileChangedShellPost", {
    group = auto_reload_group,
    callback = function()
        vim.notify("File changed on disk", vim.log.levels.WARN, { title = "Buffer reloaded" })
    end,
})

api.nvim_create_autocmd({ "FocusGained", "CursorHold" }, {
    group = auto_reload_group,
    callback = function()
        if vim.fn.getcmdwintype() == "" then
            vim.cmd("checktime")
        end
    end,
})

api.nvim_create_autocmd("VimResized", {
    group = augroup("auto_resize_tabs"),
    desc = "Resize all tabs on vim resizing",
    command = "wincmd =",
})

local disable_cmd_smartcase_group = augroup("disable_cmd_smartcase_group")

api.nvim_create_autocmd("CmdlineEnter", {
    group = disable_cmd_smartcase_group,
    desc = "Disable smartcase in cmd line mode",
    command = "set nosmartcase",
})

api.nvim_create_autocmd("CmdlineLeave", {
    group = disable_cmd_smartcase_group,
    desc = "Disable smartcase in cmd line mode",
    command = "set smartcase",
})

api.nvim_create_autocmd("TermOpen", {
    group = augroup("disable_term_numbers"),
    desc = "Disable numbers in terminal",
    command = "setlocal norelativenumber nonumber",
})

api.nvim_create_autocmd("TermOpen", {
    group = augroup("open_term_in_insert_mode"),
    desc = "Open terminal in insert mode",
    command = "startinsert",
})

api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
    group = augroup("check_is_git_repo"),
    desc = "Trigger custom event if in git repo",
    callback = function()
        local output = vim.fn.system({ "git", "rev-parse", "--is-inside-work-tree" })
        if string.match(output, "true") then
            api.nvim_command("doautocmd User GitRepoIn")
        end
    end,
})

api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    group = augroup("check_is_dockerfile"),
    desc = "Set Dockerfile filetype",
    pattern = "Dockerfile*",
    callback = function()
        vim.opt_local.filetype = "dockerfile"
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

api.nvim_create_autocmd({ "FileType" }, {
    group = api.nvim_create_augroup("handle_large_file", { clear = true }),
    pattern = "bigfile",
    callback = function(ev)
        local path = vim.fn.fnamemodify(api.nvim_buf_get_name(ev.buf), ":p:~:.")
        vim.notify(("Big file detected: `%s`"):format(path), vim.log.levels.INFO, { title = "Big File" })

        api.nvim_set_option_value("relativenumber", false, { scope = "local" })
        api.nvim_set_option_value("swapfile", false, { scope = "local" })
        api.nvim_set_option_value("bufhidden", "unload", { scope = "local" })
        api.nvim_set_option_value("buftype", "nowrite", { scope = "local" })
        api.nvim_set_option_value("undolevels", -1, { scope = "local" })
    end,
})
