return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
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
    deactivate = function()
        vim.cmd([[Neotree close]])
    end,
}
