-- standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- widget and layout library
local wibox = require("wibox")
-- theme handling library
local beautiful = require("beautiful")
-- notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- enable hotkeys help widget for vim and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Autostart

awful.spawn.with_shell("picom")
awful.spawn.with_shell("feh --bg-scale /mnt/Arquivo/imagens/persona5.jpeg")
awful.spawn.with_shell("setxkbmap -layout br -variant abnt2")
awful.spawn.with_shell('setxkbmap -option "caps:swapescape"')
