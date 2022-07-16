local awful = require "awful"
local vars = require "vars"

if vars.ui.enable_bar == "true" then
    require("userconf.tema." .. vars.ui.bar_tema .. ".bar")
end
require("userconf.tema." .. vars.ui.titlebar_tema .. ".titlebar")
--require("userconf.tema." .. vars.ui.notif_tema .. ".notif")