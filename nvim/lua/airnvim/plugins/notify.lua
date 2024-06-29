return {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = {
        stages = "static",
        timeout = 3000,
        background_colour = "#2E3440",
    },
    init = function()
        vim.notify = require("notify")
    end,
}
