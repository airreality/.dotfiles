return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    -- config = function()
    --     require("config.neo-tree")
    -- end,
    keys = {
        {
            "<leader>t",
            function()
                require("neo-tree.command").execute({ toggle = true })
            end,
            desc = "toggle neo-tree",
        },
    },
    init = function()
        -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
        -- because `cwd` is not set up properly.
        vim.api.nvim_create_autocmd("BufEnter", {
            group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
            desc = "Start Neo-tree with directory",
            once = true,
            callback = function()
                if package.loaded["neo-tree"] then
                    return
                else
                    local stats = vim.uv.fs_stat(vim.fn.argv(0))
                    if stats and stats.type == "directory" then
                        require("neo-tree")
                    end
                end
            end,
        })
    end,
}
