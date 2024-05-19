require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "bash",
        "diff",
        "html",
        "javascript",
        "json",
        "jsonc",
        "dockerfile",
        "fish",
        "hurl",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "toml",
        "typescript",
        "vim",
        "xml",
        "yaml",
    },
    highlight = {
        enable = true,
        disable = function(_, buf)
            local max_filesize = 1 * 1024 * 1024 -- 1 MB
            local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
    },
    indent = { enabled = true },
})
