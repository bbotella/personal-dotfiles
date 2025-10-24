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

-- Bypass mouse reporting to applications when these modifiers are pressed
-- This allows Cmd+Click to work in WezTerm even when Zellij has mouse mode enabled
config.bypass_mouse_reporting_modifiers = "CMD"

-- Default program
config.default_prog = { "/opt/homebrew/bin/zellij" }

-- Tab bar
config.hide_tab_bar_if_only_one_tab = true

-- Hyperlink rules - make URLs and file paths clickable
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- Mouse bindings for clickable links
config.mouse_bindings = {
  -- Open links with Cmd+Click (works with Zellij)
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CMD",
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
  -- Select text with left click drag (default behavior)
  {
    event = { Down = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = wezterm.action.SelectTextAtMouseCursor("Cell"),
  },
  -- Paste with middle click
  {
    event = { Down = { streak = 1, button = "Middle" } },
    mods = "NONE",
    action = wezterm.action.PasteFrom("Clipboard"),
  },
}

-- and finally, return the configuration to wezterm
return config
