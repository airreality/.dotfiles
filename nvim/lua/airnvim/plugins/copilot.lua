local utils = require("airnvim.utils")

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
        opts = {
            model = "claude-3.7-sonnet",
        },
        config = function(_, opts)
            if utils.executable("node") then
                require("CopilotChat").setup(opts)
            end
        end,
        keys = {
            {
                "<space>h",
                function()
                    vim.cmd("CopilotChatToggle")
                    vim.cmd("wincmd =")
                end,
                mode = { "n", "v" },
                desc = "Copilot chat",
            },
        },
    },
}
