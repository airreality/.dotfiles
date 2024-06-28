return {
    "stevearc/conform.nvim",
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format()
            end,
            desc = "format buffer",
        },
    },
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                bash = { "shfmt" },
                fish = { "fish_indent" },
                json = { "jq" },
                lua = { "stylua" },
                python = { "ruff_format", "ruff_organize_imports" },
                sh = { "shfmt" },
                yaml = { "yq" },
            },
            notify_on_error = true,
        })
        conform.formatters.shfmt = {
            prepend_args = function(_, _)
                return { "-i", 4 }
            end,
        }
    end,
}
