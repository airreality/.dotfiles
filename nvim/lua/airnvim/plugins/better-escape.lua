return {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
        require("better_escape").setup({
            mappings = {
                i = {
                    j = { j = "<Esc>" },
                },
            },
            timeout = 150,
        })
    end,
}
