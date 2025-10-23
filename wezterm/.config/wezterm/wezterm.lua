-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- Color scheme
config.color_scheme = "Catppuccin Macchiato"

-- Font configuration
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 14.0

-- Default program
config.default_prog = { "/opt/homebrew/bin/zellij" }

-- Tab bar
config.hide_tab_bar_if_only_one_tab = true

-- and finally, return the configuration to wezterm
return config
