return {
    "kevinhwang91/nvim-hlslens",
    branch = "main",
    keys = { "*", "#", "n", "N" },
    opts = {
        calm_down = true,
        nearest_only = true,
    },
    config = function(_, opts)
        local hlslens = require("hlslens")

        hlslens.setup(opts)

        local activate_hlslens = function(direction)
            local cmd = string.format("normal! %s%szzzv", vim.v.count1, direction)
            local status, msg = pcall(vim.cmd, cmd)

            if not status then
                local start_idx, _ = string.find(msg, "E486", 1, true)
                if start_idx then
                    local msg_part = string.sub(msg, start_idx)
                    vim.api.nvim_err_writeln(msg_part)
                end
                return
            end

            hlslens.start()
        end

        vim.keymap.set("n", "n", "", {
            callback = function()
                activate_hlslens("n")
            end,
        })

        vim.keymap.set("n", "N", "", {
            callback = function()
                activate_hlslens("N")
            end,
        })

        vim.keymap.set("n", "*", "", {
            callback = function()
                vim.fn.execute("normal! *N")
                hlslens.start()
            end,
        })
        vim.keymap.set("n", "#", "", {
            callback = function()
                vim.fn.execute("normal! #N")
                hlslens.start()
            end,
        })
    end,
}
