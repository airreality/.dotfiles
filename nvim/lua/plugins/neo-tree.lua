return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
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
