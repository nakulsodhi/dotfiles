-- Standard awesome library
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Theme handling library
local beautiful = require("beautiful") -- for awesome.icon

local M = {}  -- menu
local _M = {} -- module

-- reading
-- https://awesomewm.org/apidoc/popups%20and%20bars/awful.menu.html




terminal = RC.vars.terminal

-- This is used later as the default terminal and editor to run.
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

M.favorites = {
    {"browser", "firefox"},
    {"network", terminal .." -e nmtui"}
}

M.awesome = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}


function _M.get()

-- Main Menu
 local menu_items =  {
     { "awesome", M.awesome, "~/.config/awesome/theme/Void_Linux_logo.svg.png" },
     { "open terminal", terminal },
     { "favorites", M.favorites}
 }
 return menu_items
end

return setmetatable(
  {}, 
  { __call = function(_, ...) return _M.get(...) end }
)
