local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

config.color_scheme = "OneNord"

config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.underline_thickness = 3
config.cursor_thickness = 4
config.underline_position = -6

config.font_size = 13
config.font = wezterm.font({ family = "Fira Code" })
config.bold_brightens_ansi_colors = true

config.force_reverse_video_cursor = true
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.scrollback_lines = 10000

config.hyperlink_rules = wezterm.default_hyperlink_rules()
table.insert(config.hyperlink_rules, {
    regex = [[(WCCA|WEBCC|SA|ENV|CCC|CCBE|CCAC|CBCT|IDS|CWS|CCBA|DA|ATD|MDS|TCHL)-\d+]],
    format = "https://jira.aligntech.com/browse/$0",
})
table.insert(config.hyperlink_rules, {
    regex = [[(WCCA|WEBCC|SA|ENV|CCC|CCBE|CCAC|CBCT|IDS|CWS|CCBA|DA|ATD|MDS|TCHL)-T\d+]],
    format = "https://jira.aligntech.com/secure/Tests.jspa#/testCase/$0",
})

return config
