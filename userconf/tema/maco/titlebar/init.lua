local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local wmargin = wibox.container.margin

client.connect_signal("request::titlebars", function(c)
  -- buttons for the titlebar
  local buttons = {
    awful.button({}, 1, function()
      c:activate { context = "titlebar", action = "mouse_move" }
    end),
    awful.button({ "Shift" }, 1, function()
      c:activate { context = "titlebar", action = "mouse_resize" }
    end),
    awful.button({}, 3, function()
      c:activate { context = "titlebar", action = "mouse_resize" }
    end),
  }

  awful.titlebar(c, { size = dpi(24), position = "top", bg = beautiful.xbackground, fg = beautiful.xforeground, }):setup {
      wmargin(awful.titlebar.widget.closebutton(c), 7, 2, 6, 6),
      wmargin(awful.titlebar.widget.maximizedbutton(c), 2, 2, 6, 6),
      wmargin(awful.titlebar.widget.minimizebutton(c), 2, 2, 6, 6),
      layout = wibox.layout.fixed.horizontal,
      spacing = dpi(4),
    }
end)