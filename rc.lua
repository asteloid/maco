require "awful.autofocus"
-- awesome library
local gtimer = require "gears.timer"
--local beautiful = require "beautiful"
local gfs = require "gears.filesystem"
local collectgarbage = collectgarbage

collectgarbage("setpause", 100)
collectgarbage("setstepmul", 400)

--local dark_mode = "true"

require("beautiful").init(require("gears").filesystem.get_configuration_dir() .. "themes/maco/theme.lua")

--[[]]
local naughty = require "naughty"

naughty.connect_signal("request::display_error", function(message, startup)
  naughty.notification {
    urgency = "critical",
    title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
    message = message,
  }
end)
--]]

require "conf"
require "conf.akuse"
-- userconf
require "userconf"

gtimer { timeout = 5, autostart = true, call_now = true, callback = function()
    collectgarbage("collect")
end }
--]]