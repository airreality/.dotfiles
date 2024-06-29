return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
        local opts = {
            options = {
                icons_enabled = true,
                theme = "auto",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = {},
                always_divide_middle = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    "branch",
                    {
                        "diff",
                        symbols = {
                            added = " ",
                            modified = " ",
                            removed = " ",
                        },
                        source = function()
                            local gitsigns = vim.b.gitsigns_status_dict
                            if gitsigns then
                                return {
                                    added = gitsigns.added,
                                    modified = gitsigns.changed,
                                    removed = gitsigns.removed,
                                }
                            end
                        end,
                    },
                    {
                        function()
                            if vim.bo.filetype ~= "python" then
                                return ""
                            end

                            local venv_path = os.getenv("VIRTUAL_ENV")

                            if venv_path == nil then
                                return ""
                            else
                                local venv_name = vim.fn.fnamemodify(venv_path, ":t")
                                return string.format("  %s (venv)", venv_name)
                            end
                        end,
                        color = { fg = "black", bg = "#F1CA81" },
                    },
                },
                lualine_c = {
                    "filename",
                    {
                        function()
                            if vim.o.spell then
                                return string.format("[SPELL]")
                            end
                            return ""
                        end,
                        color = { fg = "black", bg = "#A7C080" },
                    },
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        symbols = { error = " ", warn = " ", info = " ", hint = " " },
                    },
                },
                lualine_x = {
                    "encoding",
                    {
                        "fileformat",
                        symbols = {
                            unix = "unix",
                            dos = "win",
                            mac = "mac",
                        },
                    },
                    "filetype",
                },
                lualine_y = {
                    "location",
                    "progress",
                },
                lualine_z = {},
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            extensions = { "quickfix", "fugitive", "neo-tree", "lazy" },
        }
        return opts
    end,
}
