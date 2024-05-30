local wezterm = require('wezterm')
-- local mux = wezterm.mux
local config = {}

config.color_scheme = 'tokyonight_night'
config.colors = {
    background = "black"
}
config.window_background_opacity = 0.90

config.font = wezterm.font('JetBrains Mono')
config.font_size = 13

config.enable_tab_bar = false
config.disable_default_key_bindings = true

config.scrollback_lines = 3500

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

local act = wezterm.action
config.keys = {
    { key = 'V',          mods = 'SHIFT|CTRL',     action = act.PasteFrom 'Clipboard' },
    { key = 'v',          mods = 'SHIFT|CTRL',     action = act.PasteFrom 'Clipboard' },
    { key = 'c',          mods = 'SHIFT|CTRL',     action = act.CopyTo 'Clipboard' },
    { key = 'C',          mods = 'SHIFT|CTRL',     action = act.CopyTo 'Clipboard' },
}

return config

