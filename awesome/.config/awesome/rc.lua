-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
require("main.error-handling")

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")


RC = {} -- global namespace, on top before require any modules
RC.vars = require("main.user-variables")
modkey = RC.vars.modkey-- https://awesomewm.org/apidoc/popups%20and%20bars/awful.menu.html


local main = {
  layouts = require("main.layouts"),
  tags    = require("main.tags"),
  menu    = require("main.menu"),
  rules   = require("main.rules"),
}


--layouts
RC.layouts = main.layouts()

--tags
RC.tags = main.tags()

-- {{{ Menu
RC.mainmenu = awful.menu({items = main.menu()})
RC.launcher = awful.widget.launcher({image = beautiful.awesome_icon, menu = RC.mainmenu })
-- }}}
menubar.utils.terminal = RC.vars.terminal
-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()





--binding shit
local binding = {
    globalbuttons = require("bindings.globalbuttons"),
    clientbuttons = require("bindings.clientbuttons"),
    globalkeys = require("bindings.globalkeys"),
    clientkeys = require("bindings.clientkeys"),
    bindtotags = require("bindings.bindtotags")



}




--theme
beautiful.init("~/.config/awesome/deco/theme.lua")


-- {{{ Wibar




require("deco.statusbar")
-- }}}

-- {{{ Mouse bindings


-- }}}

-- {{{ Key bindings
RC.globalkeys = binding.globalkeys()
RC.globalkeys = binding.bindtotags(RC.globalkeys)




-- Set keys
root.buttons(binding.globalbuttons())
root.keys(RC.globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = main.rules(binding.clientkeys(), binding.clientbuttons() )
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
require("main.signals")
require("deco.titlebar")
-- }}}



--Autostart Applications
awful.spawn.with_shell("wal -R")
awful.spawn.with_shell("unclutter")
awful.spawn.with_shell("nm-applet")
