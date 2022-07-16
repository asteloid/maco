local awful = require "awful"
local browser = "librewolf"
local terminal = "urxvtc"
local filemanager = "pcmanfm"
local app_launcher = "rofi -show drun"

return {
    autorun = {
        apps = {
            --[[ example ]]
            "picom --dbus --config ${HOME}/.config/awesome/picom.conf",
            "urxvtd -f -q -o",
            "mpd",
            "fcitx",
            "pcmanfm -d",
            "/usr/libexec/polkit-gnome-authentication-agent-1",
            "brightnessctl s 200"
        },
    },
    default = {
        app_launcher = app_launcher,
        terminal = terminal,
        filemanager = filemanager,
        browser = browser,
        editor = "nvim",
        simpleditor = "micro",
        screenshot = {
            full = "",
            area = "",
            window = "",
        }
    },
    awmenu = {
        appmenu = {
            {"Apps", function() awful.spawn.with_shell(app_launcher, false) end},
            {"Browser", function() awful.spawn.with_shell(browser, false) end},
            {"Terminal", function() awful.spawn.with_shell(terminal, false) end},
            {"File Manager", function() awful.spawn.with_shell(filemanager, false) end},
        },
        powermenu = {
            {"Reload", function() awesome.restart() end},
            {"Logout", function() awesome.quit() end},
            {"Suspend", function() awful.spawn.with_shell("loginctl suspend", false) end},
            {"Hibernate", function() awful.spawn.with_shell("loginctl hibernate", false) end},
            {"Reboot", function() awful.spawn.with_shell("loginctl reboot", false) end},
            {"Shutdown", function() awful.spawn.with_shell("loginctl poweroff", false) end},
        },
    },
    ui = {
        -- theme
        awtema = "maco",
        -- enable client rounding - 0 = disable
        border_radius = 6,
        -- taglist
        tags = { "1", "2", "3", "4", "5" }, -- dont change
        --[[layout_tema = "putih",--]]
        --- layout ---
        --[[ move to -- conf/layout
        layouts = {
              l.tile,
              l.floating,
              l.spiral,
              l.tile.bottom,
        },
        --]]
        -- tema
        enable_bar = "true",
        bar_tema = "maco", -- default, maco, etc...
        titlebar_tema = "maco", -- default, maco, etc...
        notif_tema = "maco", -- default, maco, etc...
        notif_pos = "top_middle", -- *top_right* *top_left* *bottom_left* *bottom_right* *top_middle* *bottom_middle*
        notif_timeout = 5,
        --notif_width = 350,
        --notif_height = 400,
    },
    weather = {
        city = "Bandung",
    },
    user = {
        username = "asteloid", --os.getenv("USER")
        machinename = "ramentabetainooo",
        ls_pass = "ramendaisuki",
    },
    --- class only - run "xprop WM_CLASS" and then click on any window that you want to know what wm_class it has.
    ruled = {
        client_floating = {
            "Arandr",
            "Lxappearance",
            "Blueman-manager",
            "feh",
            "mpv",
            "dmenulua",
        },
        tagone = {
            "URxvt",
        },
        tagtwo = {
            "librewolf",
            "discord",
            "Chromium",
        },
        tagthree = {
            "mpv",
            "Spotify",
        },
        tagfour = {
            "LibreOffice",
        },
        tagfive = {
            "Pcmanfm",
            "File-roller",
        },
    }
}