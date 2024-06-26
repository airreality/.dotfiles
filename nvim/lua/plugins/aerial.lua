return {
    "stevearc/aerial.nvim",
    keys = {
        { "<leader>l", "<cmd>AerialToggle!<cr>", desc = "Aerial" },
    },
    config = function()
        require("aerial").setup({})
    end,
}
