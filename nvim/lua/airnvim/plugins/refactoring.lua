return {
    {
        "ThePrimeagen/refactoring.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            { "<leader>r", "", mode = { "n", "v" }, desc = "+refactor" },
            {
                "<leader>rs",
                function()
                    require("refactoring").select_refactor()
                end,
                mode = "v",
                desc = "Refactor",
            },
            {
                "<leader>ri",
                function()
                    require("refactoring").refactor("Inline Variable")
                end,
                mode = { "n", "v" },
                desc = "Inline Variable",
            },
            {
                "<leader>rb",
                function()
                    require("refactoring").refactor("Extract Block")
                end,
                desc = "Extract Block",
            },
            {
                "<leader>rf",
                function()
                    require("refactoring").refactor("Extract Block To File")
                end,
                desc = "Extract Block To File",
            },
            {
                "<leader>rp",
                function()
                    require("refactoring").debug.print_var({ normal = true })
                end,
                desc = "Debug Print Variable",
            },
            {
                "<leader>rc",
                function()
                    require("refactoring").debug.cleanup({})
                end,
                desc = "Debug Cleanup",
            },
            {
                "<leader>rf",
                function()
                    require("refactoring").refactor("Extract Function")
                end,
                mode = "v",
                desc = "Extract Function",
            },
            {
                "<leader>rF",
                function()
                    require("refactoring").refactor("Extract Function To File")
                end,
                mode = "v",
                desc = "Extract Function To File",
            },
            {
                "<leader>rx",
                function()
                    require("refactoring").refactor("Extract Variable")
                end,
                mode = "v",
                desc = "Extract Variable",
            },
            {
                "<leader>rp",
                function()
                    require("refactoring").debug.print_var()
                end,
                mode = "v",
                desc = "Debug Print Variable",
            },
        },
        opts = {
            print_var_statements = {
                python = { 'print(f"%s {%s=}")' },
            },
            show_success_message = true, -- shows a message with information about the refactor on success
        },
        config = function(_, opts)
            require("refactoring").setup(opts)
        end,
    },
}
