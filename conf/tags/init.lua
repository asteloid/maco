local awful = require "awful"
local vars = require "vars"

screen.connect_signal("request::desktop_decoration", function(s)
    --- Each screen has its own tag table.
    awful.tag(vars.ui.tags, s, awful.layout.layouts[1])
end)
