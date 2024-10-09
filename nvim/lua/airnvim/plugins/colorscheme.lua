return {
    "rmehri01/onenord.nvim",
    lazy = false,
    priority = 52,
    init = function()
        require("onenord").setup({
            styles = {
                comments = "italic",
            },
        })
    end,
}
