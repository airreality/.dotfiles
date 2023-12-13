local function spell()
    if vim.o.spell then
        return string.format("[SPELL]")
    end
    return ""
end

local diff = function()
    local git_status = vim.b.gitsigns_status_dict
    if git_status == nil then
        return
    end

    local modify_num = git_status.changed
    local remove_num = git_status.removed
    local add_num = git_status.added
    local info = { added = add_num, modified = modify_num, removed = remove_num }
    return info
end

local venv = function()
    if vim.bo.filetype ~= "python" then
        return ""
    end

    local venv_path = os.getenv("VIRTUAL_ENV")

    if venv_path == nil then
        return ""
    else
        local venv_name = vim.fn.fnamemodify(venv_path, ":t")
        return string.format("  %s (venv)", venv_name)
    end
end

require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            "branch",
            {
                "diff",
                source = diff,
            },
            {
                venv,
                color = { fg = "black", bg = "#F1CA81" },
            },
        },
        lualine_c = {
            "filename",
            {
                spell,
                color = { fg = "black", bg = "#A7C080" },
            },
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = { error = "🆇 ", warn = "⚠️ ", info = "ℹ️ ", hint = " " },
            },
        },
        lualine_x = {
            "encoding",
            {
                "fileformat",
                symbols = {
                    unix = "unix",
                    dos = "win",
                    mac = "mac",
                },
            },
            "filetype",
        },
        lualine_y = {
            "location",
            "progress",
        },
        lualine_z = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = { "quickfix", "fugitive", "nvim-tree" },
})
