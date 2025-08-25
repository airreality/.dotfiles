local api = vim.api
local lsp = vim.lsp
local diagnostic = vim.diagnostic

local utils = require("airnvim.utils")

local function notify_executable_not_found(executable)
    vim.notify(executable .. " not found!", vim.log.levels.WARN, { title = "nvim lsp config" })
end

local custom_attach = function(client, bufnr)
    diagnostic.config({
        underline = false,
        virtual_text = false,
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = " ",
                [vim.diagnostic.severity.WARN] = " ",
                [vim.diagnostic.severity.HINT] = " ",
                [vim.diagnostic.severity.INFO] = " ",
            },
        },
        severity_sort = true,
    })

    local set_qflist = function(buf_num, severity)
        local diagnostics = nil
        diagnostics = diagnostic.get(buf_num, { severity = severity })

        local qf_items = diagnostic.toqflist(diagnostics)
        vim.fn.setqflist({}, " ", { title = "Diagnostics", items = qf_items })
        vim.cmd([[copen]])
    end

    local map = function(mode, l, r, opts)
        opts = opts or {}
        opts.silent = true
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end

    map("n", "<leader>g", vim.lsp.buf.definition, { desc = "Go to definition" })
    map("n", "<leader>k", vim.lsp.buf.hover, { desc = "Hover" })
    map("n", "<leader>rr", vim.lsp.buf.rename, { desc = "Rename variable" })
    map("n", "<leader>e", vim.lsp.buf.references, { desc = "Show references" })
    map("n", "[d", function()
        diagnostic.jump({ count = -1, float = true })
    end, { desc = "Prev diagnostic" })
    map("n", "]d", function()
        diagnostic.jump({ count = 1, float = true })
    end, { desc = "Next diagnostic" })
    -- put diagnostics from current buffer to quickfix
    map("n", "<leader>b", function()
        set_qflist(bufnr)
    end, { desc = "Put buffer diagnostics to qf" })
    map("n", "<space>c", vim.lsp.buf.code_action, { desc = "LSP code action" })
    map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
    map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
    map("n", "<space>wl", function()
        vim.print(vim.lsp.buf.list_workspace_folders())
    end, { desc = "List workspace folder" })

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

local function init_pylsp()
    if not utils.executable("pylsp") then
        notify_executable_not_found("pylsp")
        return
    end

    vim.lsp.config("pylsp", {
        on_attach = custom_attach,
        settings = {
            pylsp = {
                plugins = {
                    black = { enabled = false },
                    autopep8 = { enabled = false },
                    yapf = { enabled = false },
                    pylint = { enabled = false },
                    ruff = { enabled = false },
                    pyflakes = { enabled = false },
                    pycodestyle = { enabled = false },
                    pylsp_mypy = { enabled = false },
                    jedi_completion = { fuzzy = true },
                    isort = { enabled = false },
                },
            },
        },
        flags = { debounce_text_changes = 200 },
        capabilities = require("blink.cmp").get_lsp_capabilities(),
    })
    vim.lsp.enable("pylsp")
end

local function init_ruff(py_path)
    if not utils.executable("ruff") then
        notify_executable_not_found("ruff")
        return
    end
    vim.lsp.config("ruff", {
        on_attach = custom_attach,
        init_options = {
            settings = {
                interpreter = { py_path },
                fixAll = true,
                organizeImports = true,
                showSyntaxErrors = true,
                logLevel = "warn",
                codeAction = {
                    disableRuleComment = { enable = true },
                    fixViolation = { enable = true },
                },
                lint = {
                    enable = true,
                    preview = false,
                },
            },
        },
    })
    vim.lsp.enable("ruff")
end

local function init_ty(py_path)
    if not utils.executable("ty") then
        notify_executable_not_found("ty")
        return
    end
    vim.lsp.config("ty", {
        settings = {
            ty = {
                interpreter = { py_path },
            },
        },
    })
    vim.lsp.enable("ty")
end

local function init_lua_language_server()
    if not utils.executable("lua-language-server") then
        notify_executable_not_found("lua-language-server")
        return
    end
    vim.lsp.config("lua_ls", {
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
                        vim.env.VIMRUNTIME,
                        vim.fn.stdpath("config"),
                    },
                    maxPreload = 2000,
                    preloadFileSize = 50000,
                },
            },
        },
        capabilities = require("blink.cmp").get_lsp_capabilities(),
    })
    vim.lsp.enable("lua_ls")
end

local function init_bash_language_server()
    if not utils.executable("bash-language-server") then
        notify_executable_not_found("bash-language-server")
        return
    end
    vim.lsp.config("bashls", {
        on_attach = custom_attach,
    })
    vim.lsp.enable("bashls")
end

local function init_json_language_server()
    if not utils.executable("vscode-json-language-server") then
        notify_executable_not_found("vscode-json-language-server")
        return
    end
    vim.lsp.config("jsonls", {
        on_attach = custom_attach,
        settings = {
            json = {
                format = { enable = false },
                validate = { enable = true },
            },
        },
    })
    vim.lsp.enable("jsonls")
end

local function init_yaml_language_server()
    if not utils.executable("yaml-language-server") then
        notify_executable_not_found("yaml-language-server")
        return
    end
    vim.lsp.config("yamlls", {
        on_attach = custom_attach,
        settings = {
            yaml = {
                format = { enable = false },
                validate = true,
                completion = true,
            },
        },
    })
    vim.lsp.enable("yamlls")
end

local function init_docker_language_server()
    if not utils.executable("docker-langserver") then
        notify_executable_not_found("docker-langserver")
        return
    end
    vim.lsp.config("dockerls", {
        on_attach = custom_attach,
    })
    vim.lsp.enable("dockerls")
end

local function init_markdown_language_server()
    if not utils.executable("marksman") then
        notify_executable_not_found("marksman")
        return
    end
    vim.lsp.config("marksman", {
        on_attach = custom_attach,
    })
    vim.lsp.enable("marksman")
end

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufRead", "BufNewFile" },
        config = function()
            local py_path = utils.python_path()
            init_pylsp()
            init_ruff(py_path)
            init_ty(py_path)
            init_lua_language_server()
            init_bash_language_server()
            init_json_language_server()
            init_yaml_language_server()
            init_docker_language_server()
            init_markdown_language_server()

            -- change borders style
            vim.o.winborder = "rounded"
        end,
    },
    {
        "j-hui/fidget.nvim",
        event = "VeryLazy",
        init = function()
            require("fidget")
        end,
    },
}
