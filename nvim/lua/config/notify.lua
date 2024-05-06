local nvim_notify = require("notify")

nvim_notify.setup({
    stages = "static",
    timeout = 1500,
    background_colour = "#2E3440",
})

vim.notify = nvim_notify
