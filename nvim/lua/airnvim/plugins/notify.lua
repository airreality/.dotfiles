return {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = {
        stages = "static",
        timeout = 3000,
        background_colour = "#2E3440",
    },
    config = function(_, opts)
        local notify = require("notify")
        notify.setup(opts)
        vim.notify = notify
    end,
}
