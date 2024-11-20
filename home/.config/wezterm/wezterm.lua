local wezterm = require("wezterm")
local act = wezterm.action
local sessionizer = require("sessionizer")

-- local mux = wezterm.mux
local config = {}

-- config.default_prog = { "/bin/zsh" }

config.color_scheme = "tokyonight_night"

local colors = {
    bg = "#121212",
    fg = "#A9B0D5"
}

config.colors = {
    background = colors.bg,
    tab_bar = {
        background = colors.bg,
        active_tab = {
            bg_color = colors.bg,
            fg_color = colors.fg,
            intensity = "Bold",
            underline = "None",
            italic = false,
            strikethrough = false,
        },
        inactive_tab = {
            bg_color = colors.bg,
            fg_color = colors.fg,
            intensity = "Normal",
            underline = "None",
            italic = false,
            strikethrough = false,
        },
        inactive_tab_hover = {
            bg_color = colors.fg,
            fg_color = colors.bg,
            underline = "None",
            italic = false,
            strikethrough = false,
        },
        new_tab = {
            bg_color = colors.bg,
            fg_color = colors.fg,
            intensity = "Bold",
            underline = "None",
            italic = false,
            strikethrough = false,
        },
        new_tab_hover = {
            bg_color = colors.fg,
            fg_color = colors.bg,
            intensity = "Bold",
            underline = "None",
            italic = false,
            strikethrough = false,
        },
    },
}

config.window_background_opacity = 1

-- config.background = {
--     {
--         source = {
--             File = "/home/bruno/Pictures/Images/Blue-turtle-design.png",
--         },
--         hsb = { brightness = 0.05 }
--     }
-- }

config.font = wezterm.font("JetBrains Mono")
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.font_size = 14
config.scrollback_lines = 3500
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.enable_tab_bar = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

config.disable_default_key_bindings = true

-- config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 500 }

config.keys = {
    { key = "V",     mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
    { key = "v",     mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
    { key = "c",     mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
    { key = "C",     mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
    -- { key = "d",     mods = "LEADER",     action = act.ShowDebugOverlay },
    -- { key = "Enter", mods = "LEADER",     action = act.SpawnTab("CurrentPaneDomain") },
    -- { key = "x",     mods = "LEADER",     action = wezterm.action.CloseCurrentPane({ confirm = true }) },
    -- { key = "q",     mods = "LEADER",     action = wezterm.action.CloseCurrentPane({ confirm = true }) },
    -- { key = "t",     mods = "LEADER",     action = act.ShowTabNavigator },
    -- { key = "t",     mods = "LEADER",     action = act.ShowLauncherArgs({ flags = "FUZZY|TABS" }) },
    -- { key = "p",     mods = "LEADER",     action = act.ActivateTabRelative(-1) },
    -- { key = "n",     mods = "LEADER",     action = act.ActivateTabRelative(1) },
    -- { key = "v",     mods = "LEADER",     action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    -- { key = "s",     mods = "LEADER",     action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    -- { key = "h",     mods = "LEADER",     action = act.ActivatePaneDirection("Left") },
    -- { key = "j",     mods = "LEADER",     action = act.ActivatePaneDirection("Down") },
    -- { key = "k",     mods = "LEADER",     action = act.ActivatePaneDirection("Up") },
    -- { key = "l",     mods = "LEADER",     action = act.ActivatePaneDirection("Right") },
    -- { key = "h",     mods = "ALT|SHIFT",  action = act.AdjustPaneSize({ "Left", 5 }) },
    -- { key = "j",     mods = "ALT|SHIFT",  action = act.AdjustPaneSize({ "Down", 5 }) },
    -- { key = "k",     mods = "ALT|SHIFT",  action = act.AdjustPaneSize({ "Up", 5 }) },
    -- { key = "l",     mods = "ALT|SHIFT",  action = act.AdjustPaneSize({ "Right", 5 }) },
    -- {
    --     key = "T",
    --     mods = "LEADER",
    --     action = wezterm.action_callback(function(win, pane)
    --         local tab, window = pane:move_to_new_tab()
    --     end),
    -- },
    -- { key = "c", mods = "LEADER",    action = act.ActivateCopyMode },
    -- { key = "w", mods = "LEADER",    action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
    -- -- { key = "w", mods = "ALT",    action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
    -- { key = "N", mods = "LEADER", action = act.SwitchWorkspaceRelative(1) },
    -- { key = "P", mods = "LEADER", action = act.SwitchWorkspaceRelative(-1) },
    -- -- { key = ".", mods = "ALT",       action = wezterm.action_callback(sessionizer.toggle) },
    -- { key = ".", mods = "LEADER",       action = wezterm.action_callback(sessionizer.toggle) },
}

-- for i = 1, 9 do
--     -- LEADER + 1 to 9 change tab
--     table.insert(config.keys, {
--         key = tostring(i),
--         mods = 'LEADER',
--         action = act.ActivateTab(i - 1),
--     })
-- end

return config
