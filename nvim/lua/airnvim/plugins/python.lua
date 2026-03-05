return {
    {
        "linux-cultist/venv-selector.nvim",
        ft = "python",
        cmd = "VenvSelect",
        opts = {
            settings = {
                options = {
                    notify_user_on_venv_activation = true,
                    override_notify = false,
                },
            },
        },
        keys = { { "<leader>v", "<cmd>:VenvSelect<cr>", desc = "Select venv", ft = "python" } },
    },
}
