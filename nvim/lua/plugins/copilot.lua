local utils = require("utils")

return {
    {
        "zbirenbaum/copilot.lua",
        enabled = function()
            return utils.executable("node")
        end,
        cmd = "Copilot",
        build = ":Copilot auth",
        opts = {
            panel = { enabled = false },
            suggestion = { enabled = false },
        },
    },

    {
        "CopilotC-Nvim/CopilotChat.nvim",
        enabled = function()
            return utils.executable("node")
        end,
        cmd = "CopilotChatToggle",
        branch = "canary",
        dependencies = {
            "zbirenbaum/copilot.lua",
            "nvim-lua/plenary.nvim",
        },
        init = function()
            require("CopilotChat").setup({})
        end,
    },
}
