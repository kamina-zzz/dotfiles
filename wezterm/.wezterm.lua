-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.
config.color_scheme = 'iceberg-dark'

config.automatically_reload_config = true
config.font_size = 12.0
config.use_ime = true

----------------------------------------------------
-- Tab
----------------------------------------------------
-- show tab bar
config.show_tabs_in_tab_bar = true

----------------------------------------------------
-- keybinds
----------------------------------------------------
local act = wezterm.action
config.leader = { key = "S", mods = "CTRL|SHIFT", timeout_milliseconds = 2000 }
config.keys = {
  { key = "p", mods = "SUPER", action = act.ActivateCommandPalette },
  { key = "[", mods = "LEADER", action = act.ActivateCopyMode },
  { key = 'Enter', mods = 'ALT', action = act.DisableDefaultAssignment },
}

-- Finally, return the configuration to wezterm:
return config
