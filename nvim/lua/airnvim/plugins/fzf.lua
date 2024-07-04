return {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    config = function()
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
