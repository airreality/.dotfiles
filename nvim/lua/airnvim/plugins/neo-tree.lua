return {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
        {
            "<leader>t",
            function()
                require("neo-tree.command").execute({ toggle = true })
            end,
            desc = "Neo-tree",
        },
    },
    config = function()
        require("neo-tree").setup({
            window = { mappings = {
                ["<cr>"] = "open_with_window_picker",
            } },
            event_handlers = {
                {
                    event = "after_render",
                    handler = function()
                        vim.cmd("wincmd =")
                    end,
                },
            },
        })
    end,
    deactivate = function()
        vim.cmd([[Neotree close]])
    end,
}
