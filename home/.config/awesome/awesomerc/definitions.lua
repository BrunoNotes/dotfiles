-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
local mytheme = "/home/bruno/.config/awesome/themes/bn-theme.lua"
if file_exist(mytheme) then
    beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/bn-theme.lua")
else
    beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
end

-- set wallpaper
function set_wallpaper(s)

    local wallpaper = "/home/bruno/Pictures/imagens/persona5.jpeg"

    if file_exist(wallpaper) then
        gears.wallpaper.maximized(wallpaper, s)
        -- awful.util.spawn("feh --bg-scale /home/bruno/Pictures/imagens/persona5-1080p.jpg")
    else
        gears.wallpaper.set("#000000")
    end
end

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    awful.layout.suit.floating,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}
