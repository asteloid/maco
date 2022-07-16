local awful = require "awful"
local ruled = require "ruled"
local helpers = require "helpers"
local vars = require "vars"

ruled.client.connect_signal("request::rules", function()
  -- All clients will match this rule.
  ruled.client.append_rule({
    id = "global",
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      size_hints_honor = false,
      honor_workarea = true,
      honor_padding = true,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  })

  -- Floating clients.
  ruled.client.append_rule({
    id = "floating",
    rule_any = {
      instance = {
      	"DTA", -- DownThemAll
      	"copyq",
      	"pinentry",
      	"file_progress",
      	"Popup",
      	"Devtools",
      	"Lxappearance",
      	"nm-connection-editor",
      },
      class = vars.ruled.client_floating,
      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = { "Event Tester" },
      role = {
      	"AlarmWindow",
      	"ConfigManager",
      	"pop-up",
      	"conversation",
      	"GtkFileChooserDialog",
      },
      type = { "dialog" },
    },
    properties = { floating = true, placement = awful.placement.centered },--helpers.centered_client_placement },
  })

  -- Add titlebars to normal clients and dialogs
  ruled.client.append_rule({
    id = "titlebars",
    rule_any = { type = { "normal", "dialog", "utility", "modal", } },
    properties = { titlebars_enabled = true },
  })

  -- Add titlebars to normal clients and dialogs
  ruled.client.append_rule({
    id = "hidetitlebars",
    rule_any = { class = { "luarun" } },
    properties = { floating = true, titlebars_enabled = false, geometry = { x = 55, y = 60 } },
  })

  -- dialogs
  ruled.client.append_rule({
    id = "dialog",
    rule_any = {
      type = { "dialog" },
      name = { "calendar.google.com" },
    },
    properties = {
        titlebars_enabled = true,
    	floating = true,
    	above = true,
    	skip_decoration = true,
    	placement = awful.placement.centered, --helpers.centered_client_placement,
    },
  })

  -- img viewer
  ruled.client.append_rule({
    id = "img",
    rule_any = {
      class = { "feh" },
    },
    properties = {
        border_width = 0,
        titlebars_enabled = true,
    	floating = true,
    	above = true,
    	skip_decoration = true,
    	placement = awful.placement.centered,--helpers.centered_client_placement,
    },
  })

  -- splash
  ruled.client.append_rule({
    id = "splash",
    rule_any = {
      type = { "splash" },
      name = { "Discord Updater" },
    },
    properties = {
        titlebars_enabled = false,
    	floating = true,
    	above = true,
    	skip_decoration = true,
    	placement = awful.placement.centered,--helpers.centered_client_placement,
    },
  })

  -- utils
  ruled.client.append_rule({
    id = "utils",
    rule_any = {
      type = { "utility" },
    },
    properties = {
        titlebars_enabled = false,
    	floating = true,
    	skip_decoration = true,
    	placement = awful.placement.centered,
    },
  })

  -- modals
  ruled.client.append_rule({
    id = "modal",
    rule_any = {
      type = { "modals" },
    },
    properties = {
        titlebars_enabled = true,
    	floating = true,
    	above = true,
    	skip_decoration = true,
    	placement = awful.placement.centered,
    },
  })

  -- tags
  --- 1
  ruled.client.append_rule({
    id = "satu",
    rule_any = {
      class = vars.ruled.tagone,
    },
    properties = {
        tag = "1",
    	switch_to_tags = true,
    	size_hints_honor = false,
    	titlebars_enabled = true,
    },
  })

  --- 2
  -- browser
  ruled.client.append_rule({
    id = "dua",
    rule_any = {
      class = vars.ruled.tagtwo,
    },
    properties = {
        tag = "2",
    	switch_to_tags = true,
    	maximized_horizontal = true,
    	maximized_vertical = true,
    	maximized = true,
    	titlebars_enabled = false,
    },
  })

  --- 3
  ruled.client.append_rule({
    id = "tiga",
    rule_any = {
      class = vars.ruled.tagthree,
    },
    properties = {
        tag = "3",
    	switch_to_tags = true,
    	titlebars_enabled = true,
    },
  })

  --- 4
  ruled.client.append_rule({
    id = "empat",
    rule_any = {
      class = vars.ruled.tagfour,
    },
    properties = {
        tag = "4",
    	switch_to_tags = true,
    },
  })

  --- 5
  ruled.client.append_rule({
    id = "lima",
    rule_any = {
      class = vars.ruled.tagfive,
    },
    properties = {
        tag = "5",
    	switch_to_tags = true,
    	titlebars_enabled = true,
    	floating = true,
    },
  })

end)

ruled.notification.connect_signal("request::rules", function()
  -- All notifications will match this rule.
  ruled.notification.append_rule {
    rule = {},
    properties = {
      screen = awful.screen.preferred,
      implicit_timeout = 5,
    },
  }
end)
