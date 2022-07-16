local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local gfs = gears.filesystem
local helpers = require "helpers"
local vars = require "vars"

client.connect_signal("request::manage", function(c, context)
  -- Set the windows at the slave,
  if not awesome.startup then
    awful.client.setslave(c)
  end

  --- Add missing icon to client
  if not c.icon then
      local icon = gears.surface(gfs.get_configuration_dir() .. "themes/maco/assets/icons/default.png")
      c.icon = icon._native
      icon:finish()
  end
  --]]

  --[[
  -- show titlebar when window floating
  if c.floating then
      awful.titlebar.show(c)
  else
      awful.titlebar.hide(c)
  end
  --]]

end)

--[[]]
--- Wallpapers
--- ~~~~~~~~~-
awful.screen.connect_for_each_screen(function(s)
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper

		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end

		gears.wallpaper.maximized(wallpaper, s, false, nil)
	end
end)
--]]

-- Helper function to be used by decoration themes to enable client rounding
local function enable_rounding()
	-- Apply rounded corners to clients if needed
	--if beautiful.border_radius and beautiful.border_radius > 0 then
	if vars.ui.border_radius and vars.ui.border_radius > 0 then
		client.connect_signal("manage", function(c, startup)
			if not c.fullscreen and not c.maximized then
				c.shape = helpers.rrect(vars.ui.border_radius)
			end
		end)

		-- Fullscreen and maximized clients should not have rounded corners
		local function no_round_corners(c)
			if c.fullscreen or c.maximized then
				c.shape = gears.shape.rectangle
			else
				c.shape = helpers.rrect(vars.ui.border_radius)
			end
		end

		client.connect_signal("property::fullscreen", no_round_corners)
		client.connect_signal("property::maximized", no_round_corners)

		beautiful.snap_shape = helpers.rrect(vars.ui.border_radius * 2)
	else
		beautiful.snap_shape = gears.shape.rectangle
	end
end

enable_rounding()
