local wezterm = require("wezterm")

return {
    default_prog = { "zsh" },

    initial_cols = 80,
    initial_rows = 28,
    window_background_opacity = 0.95,
    -- window_padding = { top = 0, right = 0, bottom = 0, left = 0 },
    default_cursor_style = "BlinkingUnderline",

    -- tab_bar_at_bottom = true,
    -- enable_scroll_bar = true,

    font_size = 11.0,
    font = wezterm.font("JetBrains Mono"),
    font = wezterm.font_with_fallback({
        "Noto Color Emoji",
        "Hack",
    }),

    color_scheme = "Operator Mono Dark",
    -- color_scheme = "Afterglow",
    -- color_scheme = "Bright Lights",

    enable_wayland = true,

    check_for_updates = false,
    automatically_reload_config = false,

    keys = {
        { key = "c", mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "Clipboard" }) }, -- default example
        { key = "v", mods = "CTRL|SHIFT", action = wezterm.action({ PasteFrom = "Clipboard" }) }, -- default example
        -- {key = "v", mods = "CTRL", action = wezterm.action {PasteFrom = "Clipboard"}},
        { key = "w", mods = "ALT", action = wezterm.action({ CopyTo = "Clipboard" }) },
        { key = "y", mods = "ALT", action = wezterm.action({ PasteFrom = "Clipboard" }) },
        { key = "y", mods = "CTRL", action = wezterm.action({ PasteFrom = "Clipboard" }) },
    },
}
