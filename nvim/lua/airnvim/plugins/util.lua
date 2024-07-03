return {
    { "nvim-lua/plenary.nvim", lazy = true },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    { "MunifTanjim/nui.nvim", lazy = true },
    {
        "ten3roberts/window-picker.nvim",
        lazy = true,
        config = function()
            local picker = require("window-picker")
            picker.setup()
            picker.pick_window = function()
                return picker.select({ hl = "WindowPicker", prompt = "Pick window: " }, function(winid)
                    if not winid then
                        return nil
                    else
                        return winid
                    end
                end)
            end
        end,
    },
}
