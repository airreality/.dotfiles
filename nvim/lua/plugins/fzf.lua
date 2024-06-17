return {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
        require("fzf-lua")
    end,
    keys = {
        { "<leader>:", "<cmd>FzfLua command_history" },
        { "<leader>s", "<cmd>FzfLua files<cr>" },
        { "<leader>c", "<cmd>FzfLua buffers<cr>" },
        { "<leader>a", "<cmd>FzfLua grep<cr><cr>" },
        { "<leader>z", "<cmd>FzfLua grep_curbuf<cr><cr>" },
        { "<leader>i", "<cmd>FzfLua git_status<cr>" },
    },
}
