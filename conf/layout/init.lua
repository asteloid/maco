local awful = require "awful"
local l = awful.layout.suit

awful.layout.layouts = {
  l.tile,
  l.floating,
  l.spiral,
  l.tile.bottom,
  l.corner.nw,
  l.fair,
  l.fair.horizontal,
}