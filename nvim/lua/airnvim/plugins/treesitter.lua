return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        priority = 51,
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "bash",
                "diff",
                "html",
                "javascript",
                "json",
                "jsonc",
                "dockerfile",
                "fish",
                "hurl",
                "json",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "rst",
                "rust",
                "toml",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
            },
        },
        config = function(_, opts)
            require("nvim-treesitter").install(opts.ensure_installed)

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("apply_treesitter", { clear = true }),
                callback = function(ev)
                    local lang = vim.treesitter.language.get_lang(ev.match)
                    if not vim.tbl_contains(opts.ensure_installed, lang) then
                        return
                    end
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

                    -- local max_filesize = 1 * 1024 * 1024 -- 1 MB
                    -- local stats = vim.fs.stat(vim.api.nvim_buf_get_name(ev.buf))
                    -- if stats.size > max_filesize then
                    --   return
                    -- end

                    pcall(vim.treesitter.start, ev.buf)
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        event = "VeryLazy",
        init = function()
            vim.g.no_plugin_maps = true
        end,
        opts = {
            select = {
                lookahead = true,
                selection_modes = {
                    ["@function.inner"] = "V",
                    ["@function.outer"] = "V",
                    ["@class.inner"] = "V",
                    ["@class.outer"] = "V",
                    ["@comment.inner"] = "V",
                    ["@comment.outer"] = "V",
                },
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                    ["ao"] = "@comment.outer",
                    ["io"] = "@comment.outer",
                },
                include_surrounding_whitespace = true,
            },
            swap = {
                swap_next = {
                    ["g>"] = "@parameter.inner",
                    ["]>"] = "@function.outer",
                },
                swap_previous = {
                    ["g<"] = "@parameter.inner",
                    ["]<"] = "@function.outer",
                },
            },
            move = {
                goto_next_start = {
                    ["]f"] = "@function.outer",
                    ["]c"] = "@class.outer",
                    ["]a"] = "@parameter.inner",
                },
                goto_next_end = {
                    ["]F"] = "@function.outer",
                    ["]C"] = "@class.outer",
                    ["]A"] = "@parameter.inner",
                },
                goto_previous_start = {
                    ["[f"] = "@function.outer",
                    ["[c"] = "@class.outer",
                    ["[a"] = "@parameter.inner",
                },
                goto_previous_end = {
                    ["[F"] = "@function.outer",
                    ["[C"] = "@class.outer",
                    ["[A"] = "@parameter.inner",
                },
                set_jumps = true,
            },
        },
        config = function(_, opts)
            require("nvim-treesitter-textobjects").setup(opts)

            for keymap, query_string in pairs(opts.select.keymaps) do
                vim.keymap.set({ "x", "o" }, keymap, function()
                    require("nvim-treesitter-textobjects.select").select_textobject(query_string, "textobjects")
                end)
            end

            for keymap, query_string in pairs(opts.swap.swap_next) do
                vim.keymap.set("n", keymap, function()
                    require("nvim-treesitter-textobjects.swap").swap_next(query_string)
                end)
            end

            for keymap, query_string in pairs(opts.swap.swap_previous) do
                vim.keymap.set("n", keymap, function()
                    require("nvim-treesitter-textobjects.swap").swap_previous(query_string)
                end)
            end

            for keymap, query_string in pairs(opts.move.goto_next_start) do
                vim.keymap.set({ "n", "x", "o" }, keymap, function()
                    require("nvim-treesitter-textobjects.move").goto_next_start(query_string)
                end)
            end

            for keymap, query_string in pairs(opts.move.goto_next_end) do
                vim.keymap.set({ "n", "x", "o" }, keymap, function()
                    require("nvim-treesitter-textobjects.move").goto_next_end(query_string)
                end)
            end

            for keymap, query_string in pairs(opts.move.goto_previous_start) do
                vim.keymap.set({ "n", "x", "o" }, keymap, function()
                    require("nvim-treesitter-textobjects.move").goto_previous_start(query_string)
                end)
            end

            for keymap, query_string in pairs(opts.move.goto_previous_end) do
                vim.keymap.set({ "n", "x", "o" }, keymap, function()
                    require("nvim-treesitter-textobjects.move").goto_previous_end(query_string)
                end)
            end

            local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

            -- repeat movement with ; and ,
            -- ensure ; goes forward and , goes backward regardless of the last direction
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

            -- repeat builtin f, F, t, T with ; and ,
            vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
        end,
    },
}
