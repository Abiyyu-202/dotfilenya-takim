-- Hyprland Lua Configuration
-- Migrated to official Hyprland Lua syntax

local config_dir = os.getenv("HOME") .. "/.config/hypr"
package.path = config_dir .. "/lua/?.lua;" .. package.path

require("monitors")
require("env")
require("autostart")
require("input")
require("look")
require("layouts")
require("binds")
require("rules")

-- Backward compatibility for hyprctl dispatch exit
_G.exit = hl.dsp.exit()
