return {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
        require("better_escape").setup({
            mapping = { "jj" },
            timout = 150,
            clear_empty_lines = false,
        })
    end,
}
