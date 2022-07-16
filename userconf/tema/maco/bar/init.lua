local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local wmargin = wibox.container.margin

local bar_height = dpi(35)

awful.screen.connect_for_each_screen(function(s)

    --- load komp / wdgt
    local app_launcher = require "userconf.komp.launcher"
    --local taglist = require "userconf.komp.taglist"
    --local tasklist = require "userconf.komp.tasklist"
    --local battery = require "userconf.komp.battery"
    --local volume = require "userconf.komp.volume"
    --local clock = require "userconf.komp.clock"
    --local layoutlist = require "userconf.komp.layoutlist
    
    -- Create the wibar
    s.wibar = awful.wibar({
        position = "bottom",
        x = dpi(0),
        y = dpi(0),
        screen = s,
        bg = beautiful.xcolor0,
        height = bar_height or dpi(35),
        visible = true,
        stretch = true,
    })

    -- Add widgets
    s.wibar:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            app_launcher,
        },
        { -- Middle widgets
            layout = wibox.layout.fixed.horizontal,
            middle_init,
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            right_init,
        },
    }
end)
