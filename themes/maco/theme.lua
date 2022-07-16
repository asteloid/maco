local theme_assets = require "beautiful.theme_assets"
local xresources = require "beautiful.xresources"
local naughty = require "naughty"
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gears = require "gears"
local gcolor = gears.color.recolor_image
local gfs = require "gears.filesystem"
local themes_path = gfs.get_themes_dir()
local helpers = require "helpers"
local vars = require "vars"

-- Inherit default theme
--
local theme = dofile(themes_path .. "default/theme.lua")

local theme_path = gfs.get_configuration_dir() .. "themes/maco"

local assets_path = theme_path .. "/assets"

local icon_path = assets_path .. "/icons/"
local image_path = assets_path .. "/img/"
local titlebar_path = assets_path .. "/titlebar/"
local layout_path = assets_path .. "/layouts/"

local HOME_DIR = os.getenv("HOME")

local theme = {}

theme.icon_path = icon_path
theme.image_path = image_path
theme.iconpack_path = assets_path .. "/iconpack/"
theme.image_cache_path = HOME_DIR .. "/.cache/awesome/"

-- Load ~/.Xresources colors and set fallback colors
-- ssbg = #dfefec
theme.darker_bg = "#0a0a0b"
theme.lighter_bg = "#2d2d2e"
theme.xbackground = xrdb.background or "#151515"
theme.xbackground_alt1 = "#121213"
theme.xbackground_alt2 = "#171717"
theme.xforeground = xrdb.foreground or "#fefefe"
theme.xcolor0 = xrdb.color0 or "#222222"
theme.xcolor1 = xrdb.color1 or "#c9628f"
theme.xcolor2 = xrdb.color2 or "#5aae7a"
theme.xcolor3 = xrdb.color3 or "#f4dd8a"
theme.xcolor4 = xrdb.color4 or "#91a8e1"
theme.xcolor5 = xrdb.color5 or "#a19db6"
theme.xcolor6 = xrdb.color6 or "#5e8d87"
theme.xcolor7 = xrdb.color7 or "#e3e3e3"
theme.xcolor8 = xrdb.color8 or "#292929"
theme.xcolor9 = xrdb.color9 or "#fa78ae"
theme.xcolor10 = xrdb.color10 or "#8ee996"
theme.xcolor11 = xrdb.color11 or "#f7e895"
theme.xcolor12 = xrdb.color12 or "#a5ccfa"
theme.xcolor13 = xrdb.color13 or "#afabc5"
theme.xcolor14 = xrdb.color14 or "#8abeb7"
theme.xcolor15 = xrdb.color15 or "#fefefe"

theme.black = theme.darker_bg
theme.dark = theme.xcolor0
theme.white = theme.xcolor15
theme.red = theme.xcolor9
theme.green = theme.xcolor10
theme.yellow = theme.xcolor11
theme.blue = theme.xcolor12
theme.magenta = theme.xcolor13
theme.cyan = theme.xcolor14

theme.none = "#00000000"
theme.transparent = theme.none
theme.accent = "#7c5f8a" or theme.xcolor13
theme.accent_fg = theme.xcolor7

theme.font_name = "MapleX Code Nerd Font " or "UDEV Gothic NF " or "SFMono Nerd Font Mono "
theme.font = theme.font_name .. "9"
theme.font_icon = "Material Icons Round "
theme.font_alt_icon = "Material Icons Outlined "
theme.font_clock = "PlemolJP Console NF "

--[[
-- Bar
theme.wibar_border_width = dpi(0)
theme.wibar_border_color = theme.none
theme.taglist_squares_sel = nil
theme.taglist_squares_unsel = nil
theme.taglist_squares_sel_empty = nil
theme.taglist_squares_unsel_empty = nil
--]]

-- Backgrounds
theme.bg_color = theme.xbackground
theme.bg_normal = theme.xbackground
theme.bg_focus = theme.xbackground_alt1
theme.bg_urgent = theme.xbackground
theme.bg_minimize = theme.xbackground
theme.bg_systray = theme.xcolor0
theme.bg_diff = theme.xcolor0

-- Foregrounds
theme.fg_color = theme.xforeground
theme.fg_normal = theme.xforeground
theme.fg_focus = theme.xcolor4
theme.fg_urgent = theme.xcolor9
theme.fg_minimize = theme.xcolor5

-- Gap and borders
theme.useless_gap = dpi(5)
theme.gap_single_client = true
theme.border_width = dpi(0)
theme.border_color_normal = theme.xbackground_alt1
theme.border_color_active = theme.xbackground_alt1
theme.border_color_marked = theme.xcolor4

-- Menulist
theme.menu_border_color = theme.xbackground_alt1
theme.menu_border_width = dpi(4)
theme.menu_height = dpi(25)
theme.menu_width = dpi(200)
theme.menu_submenu = ""
theme.menu_submenu_icon = nil

-- Taglist
--[[
theme.taglist_bg = theme.xcolor0
theme.taglist_bg_focus = theme.xcolor0
theme.taglist_bg_empty = theme.xcolor0
theme.taglist_bg_occupied = theme.xcolor0
theme.taglist_bg_urgent = theme.xcolor0
theme.taglist_fg = theme.xcolor10
theme.taglist_fg_empty = theme.xforeground
theme.taglist_fg_occupied = theme.xcolor9
--]]

-- Tasklist
--[[
theme.tasklist_bg_normal = theme.xbackground
theme.tasklist_align = "center"
theme.tasklist_disable_task_name = false
theme.tasklist_disable_icon = true
--

--theme.tasklist_font = "SF Pro Text Regular 10"
theme.tasklist_bg_normal = theme.xbackground .. "99"
theme.tasklist_bg_focus = theme.xbackground
theme.tasklist_bg_urgent = "#E91E63" .. "99"
theme.tasklist_fg_focus = "#DDDDDD"
theme.tasklist_fg_urgent = "#ffffff"
theme.tasklist_fg_normal = "#AAAAAA"
--]]

-- Titlebar
theme.titlebar_bg_focus = theme.xforeground--theme.xbackground
theme.titlebar_bg_normal = theme.xforeground--theme.xbackground
theme.titlebar_fg = theme.xbackground_alt1
theme.titlebar_fg_focus = theme.xforeground
theme.client_radius = dpi(6)
--theme.titlebar_size = dpi(35)

--[[]]
theme.titlebar_close_button_normal = gcolor(titlebar_path .. "circle.svg", theme.xforeground)--xcolor1)
theme.titlebar_close_button_focus  = gcolor(titlebar_path .. "circle.svg", theme.xcolor9)

theme.titlebar_minimize_button_normal = gcolor(titlebar_path .. "circle.svg", theme.xforeground)--xcolor3)
theme.titlebar_minimize_button_focus  = gcolor(titlebar_path .. "circle.svg", theme.xcolor11)

theme.titlebar_maximized_button_normal_inactive = gcolor(titlebar_path .. "circle.svg", theme.xforeground)
theme.titlebar_maximized_button_focus_inactive  = gcolor(titlebar_path .. "circle.svg", theme.xcolor2)
theme.titlebar_maximized_button_normal_active = gcolor(titlebar_path .. "circle.svg", theme.xforeground)
theme.titlebar_maximized_button_focus_active  = gcolor(titlebar_path .. "circle.svg", theme.xcolor10)

theme.titlebar_ontop_button_normal_inactive = gcolor(titlebar_path .. "circle.svg", theme.xforeground)
theme.titlebar_ontop_button_focus_inactive  = gcolor(titlebar_path .. "circle.svg", theme.xcolor4)
theme.titlebar_ontop_button_normal_active = gcolor(titlebar_path .. "circle.svg", theme.xforeground)
theme.titlebar_ontop_button_focus_active  = gcolor(titlebar_path .. "circle.svg", theme.xcolor12)

theme.titlebar_sticky_button_normal_inactive = gcolor(titlebar_path .. "circle.svg", theme.xforeground)
theme.titlebar_sticky_button_focus_inactive  = gcolor(titlebar_path .. "circle.svg", theme.xcolor5)
theme.titlebar_sticky_button_normal_active = gcolor(titlebar_path .. "circle.svg", theme.xforeground)
theme.titlebar_sticky_button_focus_active  = gcolor(titlebar_path .. "circle.svg", theme.xcolor13)

theme.titlebar_floating_button_normal_inactive = gcolor(titlebar_path .. "circle.svg", theme.xforeground)
theme.titlebar_floating_button_focus_inactive  = gcolor(titlebar_path .. "circle.svg", theme.xcolor6)
theme.titlebar_floating_button_normal_active = gcolor(titlebar_path .. "circle.svg", theme.xforeground)
theme.titlebar_floating_button_focus_active  = gcolor(titlebar_path .. "circle.svg", theme.xcolor14)
--]]

-- Tooltip
theme.tooltip_bg = theme.xbackground_alt1
theme.tooltip_fg = theme.xforeground
--theme.tooltip_shape = helpers.rrect(vars.ui.border_radius)

-- Edge snap
theme.snap_bg = theme.xbackground
theme.snap_border_width = dpi(4)

-- rounded
theme.rounded = vars.ui.border_radius
theme.border_radius = vars.ui.border_radius

-- Icon theme
--theme.icon_path = HOME_DIR .. "/.local/share/icons/"
theme.icon_theme = "Nordzy-dark"

-- Hotkey popup
theme.hotkeys_font = theme.font_name .. "11"
theme.hotkeys_description_font = theme.font_name .. "9"
theme.hotkeys_modifiers_fg = theme.xcolor13
theme.hotkeys_border_width = 0
theme.hotkeys_group_margin = dpi(10)

-- Notifications
theme.notification_icon = icon_path .. "notification.svg"

theme.systray_icon_spacing = dpi(5)

-- Layouts
theme.layout_fairh = gcolor(layout_path .. "fairh.png", theme.accent)
theme.layout_fairv = gcolor(layout_path .. "fairv.png", theme.accent)
theme.layout_floating = gcolor(layout_path .. "floating.png", theme.accent)
theme.layout_magnifier = gcolor(layout_path .. "magnifier.png", theme.accent)
theme.layout_max = gcolor(layout_path .. "max.png", theme.accent)
theme.layout_fullscreen = gcolor(layout_path .. "fullscreen.png", theme.accent)
theme.layout_tilebottom = gcolor(layout_path .. "tilebottom.png", theme.accent)
theme.layout_tileleft = gcolor(layout_path .. "tileleft.png", theme.accent)
theme.layout_tile = gcolor(layout_path .. "tile.png", theme.accent)
theme.layout_tiletop = gcolor(layout_path .. "tiletop.png", theme.accent)
theme.layout_spiral = gcolor(layout_path .. "spiral.png", theme.accent)
theme.layout_dwindle = gcolor(layout_path .. "dwindle.png", theme.accent)
theme.layout_cornernw = gcolor(layout_path .. "cornernw.png", theme.accent)
theme.layout_cornerne = gcolor(layout_path .. "cornerne.png", theme.accent)
theme.layout_cornersw = gcolor(layout_path .. "cornersw.png", theme.accent)
theme.layout_cornerse = gcolor(layout_path .. "cornerse.png", theme.accent)

--for wp & pfp use load_uncached
-- wallpaper
theme.wallpaper = gears.surface.load_uncached(gfs.get_configuration_dir() .. "themes/maco/assets/img/wp.png")

-- profil
theme.pfp = gears.surface.load_uncached(gfs.get_configuration_dir() .. "themes/maco/assets/img/pfp.png")

-- lockscreen bg
theme.exit_screen_bg = theme.xbackground_alt1 .. "f9"

return theme