-- helpers.lua
local awful = require("awful")
local gears = require("gears")
local config_dir = gears.filesystem.get_configuration_dir()

package.cpath = package.cpath .. ";" .. config_dir .. "/lib/?.so;" .. "/usr/lib/lua-pam/?.so;"

local helpers = {}

-- Useful for periodically checking the output of a command that
-- requires internet access.
-- Ensures that `command` will be run EXACTLY once during the desired
-- `interval`, even if awesome restarts multiple times during this time.
-- Saves output in `output_file` and checks its last modification
-- time to determine whether to run the command again or not.
-- Passes the output of `command` to `callback` function.
function helpers.remote_watch(command, interval, output_file, callback)
  local run_the_thing = function()
    -- Pass output to callback AND write it to file
    awful.spawn.easy_async_with_shell(
      command .. " | tee " .. output_file,
      function(out)
        callback(out)
      end
    )
  end

  local timer
  timer =
    gears.timer {
    timeout = interval,
    call_now = true,
    autostart = true,
    single_shot = false,
    callback = function()
      awful.spawn.easy_async_with_shell(
        "date -r " .. output_file .. " +%s",
        function(last_update, _, __, exitcode)
          -- Probably the file does not exist yet (first time
          -- running after reboot)
          if exitcode == 1 then
            run_the_thing()
            return
          end

          local diff = os.time() - tonumber(last_update)
          if diff >= interval then
            run_the_thing()
          else
            -- Pass the date saved in the file since it is fresh enough
            awful.spawn.easy_async_with_shell(
              "cat " .. output_file,
              function(out)
                callback(out)
              end
            )

            -- Schedule an update for when the remaining time to complete the interval passes
            timer:stop()
            gears.timer.start_new(
              interval - diff,
              function()
                run_the_thing()
                timer:again()
              end
            )
          end
        end
      )
    end
  }
end

function helpers.module_check(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if type(loader) == "function" then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

helpers.table = {}
function helpers.table.slice(tbl, first, last, step)
  local sliced = {}

  for i = first or 1, last or #tbl, step or 1 do
    sliced[#sliced + 1] = tbl[i]
  end

  return sliced
end

-- Create rounded rectangle shape (in one line)

helpers.rrect = function(radius)
	return function(cr, width, height)
		gears.shape.rounded_rect(cr, width, height, radius)
	end
end

helpers.squircle = function(rate, delta)
	return function(cr, width, height)
		gears.shape.squircle(cr, width, height, rate, delta)
	end
end
helpers.psquircle = function(rate, delta, tl, tr, br, bl)
	return function(cr, width, height)
		gears.shape.partial_squircle(cr, width, height, tl, tr, br, bl, rate, delta)
	end
end

-- Create pi

helpers.pie = function(width, height, start_angle, end_angle, radius)
	return function(cr)
		gears.shape.pie(cr, width, height, start_angle, end_angle, radius)
	end
end

-- Create parallelogram

helpers.prgram = function(height, base)
	return function(cr, width)
		gears.shape.parallelogram(cr, width, height, base)
	end
end

-- Create partially rounded rect

helpers.prrect = function(radius, tl, tr, br, bl)
	return function(cr, width, height)
		gears.shape.partially_rounded_rect(cr, width, height, tl, tr, br, bl, radius)
	end
end

-- Create rounded bar

helpers.rbar = function(width, height)
	return function(cr)
		gears.shape.rounded_bar(cr, width, height)
	end
end

-- Markup helper

function helpers.colorize_text(txt, fg)
	return "<span foreground='" .. (fg or "") .. "'>" .. txt .. "</span>"
end

function helpers.client_menu_toggle()
	local instance = nil

	return function()
		if instance and instance.wibox.visible then
			instance:hide()
			instance = nil
		else
			instance = awful.menu.clients({ theme = { width = dpi(250) } })
		end
	end
end

-- Create powerline shape
helpers.powerline = function(width, height)
  return function(cr)
    gears.shape.powerline(cr, width, height)
  end
end

function helpers.vertical_pad(height)
	return wibox.widget({
		forced_height = height,
		layout = wibox.layout.fixed.vertical,
	})
end

function helpers.horizontal_pad(width)
	return wibox.widget({
		forced_width = width,
		layout = wibox.layout.fixed.horizontal,
	})
end

-- Maximizes client and also respects gaps
function helpers.maximize(c)
	c.maximized = not c.maximized
	if c.maximized then
		awful.placement.maximize(c, {
			honor_padding = true,
			honor_workarea = true,
			margins = beautiful.useless_gap * 2,
		})
	end
	c:raise()
end

-- Add a hover cursor to a widget by changing the cursor on
-- mouse::enter and mouse::leave
-- You can find the names of the available cursors by opening any
-- cursor theme and looking in the "cursors folder"
-- For example: "hand1" is the cursor that appears when hovering over
-- links
function helpers.add_hover_cursor(w, hover_cursor)
	local original_cursor = "left_ptr"

	w:connect_signal("mouse::enter", function()
		local w = _G.mouse.current_wibox
		if w then
			w.cursor = hover_cursor
		end
	end)

	w:connect_signal("mouse::leave", function()
		local w = _G.mouse.current_wibox
		if w then
			w.cursor = original_cursor
		end
	end)
end

-- Rounds a number to any number of decimals
function helpers.round(number, decimals)
	local power = 10 ^ decimals
	return math.floor(number * power) / power
end

function helpers.centered_client_placement(c)
	return gears.timer.delayed_call(function()
		awful.placement.centered(c, { honor_padding = true, honor_workarea = true })
	end)
end

-- Volume Control
function helpers.get_volume()
	local fd = io.popen("~/.bin/volpip.sh")
	local status = fd:read()
	fd:close()
	return tonumber(status)
end

function helpers.get_muted()
	local fd = io.popen("~/.bin/volpip.sh mute")
	local status = fd:read()
	fd:close()

	if string.find(status, "on", 1, true) then
		return false
	end
	return true
end

function helpers.volume_control(step)
	local cmd
	if step == 0 then
		cmd = "pactl set-sink-mute @DEFAULT_SINK@ toggle"
	else
		sign = step > 0 and "+" or ""
		cmd = "pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ "
			.. sign
			.. tostring(step)
			.. "%"
	end
	awful.spawn.with_shell(cmd)
end

return helpers
