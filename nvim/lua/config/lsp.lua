local fn = vim.fn
local api = vim.api
local keymap = vim.keymap
local lsp = vim.lsp
local diagnostic = vim.diagnostic

local utils = require("utils")

-- set quickfix list from diagnostics in a certain buffer, not the whole workspace
local set_qflist = function(buf_num, severity)
    local diagnostics = nil
    diagnostics = diagnostic.get(buf_num, { severity = severity })

    local qf_items = diagnostic.toqflist(diagnostics)
    vim.fn.setqflist({}, " ", { title = "Diagnostics", items = qf_items })

    -- open quickfix by default
    vim.cmd([[copen]])
end

local ruff_fix = function()
    if vim.bo.filetype ~= "python" then
      return
    end
    vim.lsp.buf.format()
    vim.lsp.buf.code_action({
        context = {
            only = { "source.fixAll.ruff" },
        },
        apply = true,
    })
end

local custom_attach = function(client, bufnr)
    local map = function(mode, l, r, opts)
        opts = opts or {}
        opts.silent = true
        opts.buffer = bufnr
        keymap.set(mode, l, r, opts)
    end
    map("n", "<leader>f", ruff_fix, { desc = "fix code" })
    map("n", "<leader>g", vim.lsp.buf.definition, { desc = "go to definition" })
    map("n", "<leader>k", vim.lsp.buf.hover)
    map("n", "<leader>r", vim.lsp.buf.rename, { desc = "variable rename" })
    map("n", "<leader>e", vim.lsp.buf.references, { desc = "show references" })
    map("n", "[d", diagnostic.goto_prev, { desc = "previous diagnostic" })
    map("n", "]d", diagnostic.goto_next, { desc = "next diagnostic" })
    -- this puts diagnostics from opened files to quickfix
    map("n", "<space>qw", diagnostic.setqflist, { desc = "put window diagnostics to qf" })
    -- this puts diagnostics from current buffer to quickfix
    map("n", "<space>qb", function()
        set_qflist(bufnr)
    end, { desc = "put buffer diagnostics to qf" })
    map("n", "<space>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
    map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { desc = "add workspace folder" })
    map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { desc = "remove workspace folder" })
    map("n", "<space>wl", function()
        vim.print(vim.lsp.buf.list_workspace_folders())
    end, { desc = "list workspace folder" })

    api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local float_opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = "rounded",
                source = "always", -- show source in diagnostic popup window
                prefix = " ",
            }

            if not vim.b.diagnostics_pos then
                vim.b.diagnostics_pos = { nil, nil }
            end

            local cursor_pos = api.nvim_win_get_cursor(0)
            if
                (cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
                and #diagnostic.get() > 0
            then
                diagnostic.open_float(nil, float_opts)
            end

            vim.b.diagnostics_pos = cursor_pos
        end,
    })

    -- The blow command will highlight the current variable and its usages in the buffer.
    if client.server_capabilities.documentHighlightProvider then
        vim.cmd([[
      hi! link LspReferenceRead Visual
      hi! link LspReferenceText Visual
      hi! link LspReferenceWrite Visual
    ]])

        local gid = api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        api.nvim_create_autocmd("CursorHold", {
            group = gid,
            buffer = bufnr,
            callback = function()
                lsp.buf.document_highlight()
            end,
        })

        api.nvim_create_autocmd("CursorMoved", {
            group = gid,
            buffer = bufnr,
            callback = function()
                lsp.buf.clear_references()
            end,
        })
    end

    if vim.g.logging_level == "debug" then
        local msg = string.format("Language server %s started!", client.name)
        vim.notify(msg, vim.log.levels.DEBUG, { title = "Nvim-config" })
    end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

if utils.executable("pylsp") then
    local venv_path = os.getenv("VIRTUAL_ENV")
    local py_path = nil
    if venv_path ~= nil then
        py_path = venv_path .. "/bin/python3"
    else
        py_path = vim.g.python3_host_prog
    end

    lspconfig.pylsp.setup({
        on_attach = custom_attach,
        settings = {
            pylsp = {
                plugins = {
                    pylsp_mypy = {
                        enabled = true,
                        overrides = { "--python-executable", py_path, true },
                        report_progress = true,
                        live_mode = false,
                    },
                    jedi_completion = { fuzzy = true },
                },
            },
        },
        flags = {
            debounce_text_changes = 200,
        },
        capabilities = capabilities,
    })
else
    vim.notify("pylsp not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

if utils.executable("ruff-lsp") then
    require("lspconfig").ruff_lsp.setup({
        init_options = {
            settings = {},
        },
        commands = {
            RuffAutofix = {
                function()
                    vim.lsp.buf.execute_command({
                        command = "ruff.applyAutofix",
                        arguments = {
                            { uri = vim.uri_from_bufnr(0) },
                        },
                    })
                end,
                description = "Ruff: Fix all auto-fixable problems",
            },
            RuffOrganizeImports = {
                function()
                    vim.lsp.buf.execute_command({
                        command = "ruff.applyOrganizeImports",
                        arguments = {
                            { uri = vim.uri_from_bufnr(0) },
                        },
                    })
                end,
                description = "Ruff: Format imports",
            },
        },
    })
else
    vim.notify("ruff-lsp not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

if utils.executable("lua-language-server") then
    lspconfig.lua_ls.setup({
        on_attach = custom_attach,
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                },
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    -- make the server aware of Neovim runtime files,
                    -- https://github.com/LuaLS/lua-language-server/wiki/Libraries#link-to-workspace .
                    -- lua-dev.nvim also has similar settings for lua ls
                    -- https://github.com/folke/neodev.nvim/blob/main/lua/neodev/luals.lua .
                    library = {
                        fn.stdpath("data") .. "/lazy/emmylua-nvim",
                        fn.stdpath("config"),
                    },
                    maxPreload = 2000,
                    preloadFileSize = 50000,
                },
            },
        },
        capabilities = capabilities,
    })
end

fn.sign_define("DiagnosticSignError", { text = "🆇", texthl = "DiagnosticSignError" })
fn.sign_define("DiagnosticSignWarn", { text = "⚠️", texthl = "DiagnosticSignWarn" })
fn.sign_define("DiagnosticSignInfo", { text = "ℹ️", texthl = "DiagnosticSignInfo" })
fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

diagnostic.config({
    underline = false,
    virtual_text = false,
    signs = true,
    severity_sort = true,
})

-- change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
lsp.handlers["textDocument/hover"] = lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})
