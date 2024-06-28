return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        priority = 51,
        build = ":TSUpdate",
        opts_extend = { "ensure_installed" },
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
                "toml",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
            },
            highlight = {
                enable = true,
                disable = function(_, buf)
                    local max_filesize = 1 * 1024 * 1024 -- 1 MB
                    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
            },
            indent = { enabled = true },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = false,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "lewis6991/gitsigns.nvim",
        },
        opts = function()
            return {
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                        include_surrounding_whitespace = true,
                    },
                    swap = {
                        enable = true,
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
                        enable = true,
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
                    },
                },
            }
        end,
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
            local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

            -- repeat movement with ;
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
            -- repeat builtin f, F, t, T with ;
            vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

            local gs = require("gitsigns")
            --
            -- -- make gitsigns.nvim movement repeatable with ;
            local next_hunk_repeat, prev_hunk_repeat =
                ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
            vim.keymap.set({ "n", "x", "o" }, "]h", next_hunk_repeat, { desc = "Next hunk" })
            vim.keymap.set({ "n", "x", "o" }, "[h", prev_hunk_repeat, { desc = "Previous hunk" })
        end,
    },
}
