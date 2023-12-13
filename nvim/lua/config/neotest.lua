local keymap = vim.keymap

require("neotest").setup({
    adapters = {
        require("neotest-python"),
    },
})

-- TODO
-- keymap.set("n", "<leader>n", require("neotest").run.run())
