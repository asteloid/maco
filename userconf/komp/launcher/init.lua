local awful = require "awful"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local wibox = require "wibox"
local wmargin = wibox.container.margin
local vars = require "vars"
local helpers = require "helpers"


local mymainmenu = awful.menu({
    items = {
        {"Apps", vars.awmenu.appmenu}, {"Powermenu", vars.awmenu.powermenu},
    }
})

local launcher = awful.widget.launcher({image = beautiful.pfp, menu = mymainmenu})

local launcher_container = wibox.widget{
    wmargin(launcher, 4, 4, 4, 4),
    forced_width = dpi(32),
    forced_height = dpi(32),
    bg = beautiful.none,
    widget = wibox.container.background
}

return wibox.widget{
    wmargin(launcher_container, 2, 2, 2, 2),
    bg = beautiful.none,
    shape = helpers.rrect(4),
    widget = wibox.container.background
}