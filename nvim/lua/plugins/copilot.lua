local utils = require("utils")

return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        opts = {
            panel = { enabled = false },
            suggestion = { enabled = false },
        },
        keys = {
            { "<space>l", "<cmd>Copilot panel<cr>", desc = "Copilot panel" },
        },
    },

    {
        "CopilotC-Nvim/CopilotChat.nvim",
        cmd = "CopilotChatToggle",
        branch = "canary",
        dependencies = {
            "zbirenbaum/copilot.lua",
            "nvim-lua/plenary.nvim",
        },
        init = function()
            if utils.executable("node") then
                require("CopilotChat").setup({})
            end
        end,
        keys = {
            { "<space>h", "<cmd>CopilotChatToggle<cr>", mode = { "n", "v" }, desc = "Copilot chat" },
        },
    },
}
