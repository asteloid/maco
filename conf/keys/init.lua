local awful = require "awful"
local hotkeys_popup = require "awful.hotkeys_popup"
local modkey = "Mod4"
local beautiful = require "beautiful"
local vars = require "vars"
local kbdcfg = require "conf.lib.keyboard_layout.kbdcfg"

-- rightclickmenu
--[[]]
local mymainmenu = awful.menu({
    items = {
        {"Apps", vars.awmenu.appmenu}, {"Powermenu", vars.awmenu.powermenu},
    }
})

awful.mouse.append_global_mousebindings({
    awful.button({}, 3, function() mymainmenu:toggle() end)
})
--]]

-- General Awesome keys
awful.keyboard.append_global_keybindings {
  awful.key({ modkey, "Shift" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey }, "Return", function()
    awful.spawn.with_shell(vars.default.terminal, false)
  end, { description = "open a terminal", group = "launcher" }),
  awful.key({ modkey }, "d", function()
    awful.spawn.with_shell(vars.default.app_launcher, false)
  end, { description = "run app launcher", group = "launcher" }),
  awful.key({modkey}, "F1", hotkeys_popup.show_help,
    {description = "show help", group = "awesome"}),
  awful.key({modkey}, "b", function()
    kbdcfg.switch_next()
  end, {description = "Change Keyboard Layout", group = "awesome"}),

}

-- Utility
awful.keyboard.append_global_keybindings {
  -- Screenshot
  awful.key({}, "Print", function()
    awful.spawn.with_shell(vars.default.screenshot.full, false)
  end, { description = "Take Full Screenshot", group = "tools" }),
  awful.key({ "Shift" }, "Print", function()
    awful.spawn.with_shell(vars.default.screenshot.area, false)
  end, { description = "Take Area Screenshot", group = "tools" }),
}

-- Tags related keybindings
awful.keyboard.append_global_keybindings {
  awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
  awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
  awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
}

-- Focus related keybindings
awful.keyboard.append_global_keybindings {
  awful.key({ modkey }, "j", function()
    awful.client.focus.byidx(1)
  end, { description = "focus next by index", group = "client" }),
  awful.key({ modkey }, "k", function()
    awful.client.focus.byidx(-1)
  end, { description = "focus previous by index", group = "client" }),
  awful.key({ "Mod1" }, "Tab", function()
    awful.client.focus.history.previous()
    if client.focus then
      client.focus:raise()
    end
  end, { description = "go back", group = "client" }),
}

awful.keyboard.append_global_keybindings {
  awful.key {
    modifiers = { modkey },
    keygroup = "numrow",
    description = "only view tag",
    group = "tag",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        tag:view_only()
      end
    end,
  },
  awful.key {
    modifiers = { modkey, "Control" },
    keygroup = "numrow",
    description = "toggle tag",
    group = "tag",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end,
  },
  awful.key {
    modifiers = { modkey, "Shift" },
    keygroup = "numrow",
    description = "move focused client to tag",
    group = "tag",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end,
  },
}

client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings {
    awful.button({}, 1, function(c)
      c:activate { context = "mouse_click" }
    end),
    awful.button({ modkey }, 1, function(c)
      c:activate { context = "mouse_click", action = "mouse_move" }
    end),
    awful.button({ modkey }, 3, function(c)
      c:activate { context = "mouse_click", action = "mouse_resize" }
    end),
  }
end)

client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings {
    awful.key({ modkey }, "f", function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end, { description = "toggle fullscreen", group = "client" }),
    awful.key({ modkey }, "q", function(c)
      c:kill()
    end, { description = "close", group = "client" }),
    awful.key(
      { modkey, "Control" },
      "space",
      awful.client.floating.toggle,
      { description = "toggle floating", group = "client" }
    ),
    awful.key({ modkey, "Control" }, "Return", function(c)
      c:swap(awful.client.getmaster())
    end, { description = "move to master", group = "client" }),
    awful.key({ modkey }, "t", function(c)
      c.ontop = not c.ontop
    end, { description = "toggle keep on top", group = "client" }),
    awful.key({ modkey }, "m", function(c)
      c.maximized = not c.maximized
      c:raise()
    end, { description = "(un)maximize", group = "client" }),
  }
end)
