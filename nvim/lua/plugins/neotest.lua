return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python",
    },
    ft = "python",
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python")({ runner = "pytest" }),
            },
            status = { virtual_text = true },
            output = { open_on_run = true },
        })
    end,
    keys = {
        {
            "<leader>nn",
            function()
                local neotest = require("neotest")
                local panel = neotest.output_panel
                panel.clear()
                panel.open()
                neotest.run.run()
            end,
            desc = "Run Nearest",
        },
        {
            "<leader>ns",
            function()
                require("neotest").summary.toggle()
            end,
            desc = "Toggle Summary",
        },
        {
            "<leader>no",
            function()
                require("neotest").output_panel.toggle()
            end,
            desc = "Toggle Output Panel",
        },
        {
            "<leader>nS",
            function()
                require("neotest").run.stop()
            end,
            desc = "Stop",
        },
    },
}
