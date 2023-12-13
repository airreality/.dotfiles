require("nvim-treesitter.configs").setup({
    ensure_installed = { "python", "lua", "vim", "json", "toml", "yaml", "dockerfile", "fish" },
    ignore_install = {},
    highlight = {
        enable = true,
        disable = function(_, buf)
            local max_filesize = 1 * 1024 * 1024 -- 1 MB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
    },
})
