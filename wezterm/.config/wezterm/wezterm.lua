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

-- Default program - auto-attach to last Zellij session or create new one
config.default_prog = { "/opt/homebrew/bin/zellij", "attach", "--create", "Work" }

-- Don't ask for confirmation when closing
config.window_close_confirmation = "NeverPrompt"

-- Window size (used on first launch or when no saved state exists)
-- WezTerm automatically remembers window size and position between sessions
config.initial_cols = 140
config.initial_rows = 40

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

-- Center window on startup with 70% of screen size
wezterm.on("gui-startup", function(cmd)
  local screen = wezterm.gui.screens().active
  local ratio = 0.7  -- 70% of the screen size
  local width, height = screen.width * ratio, screen.height * ratio
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  if window then
    window:gui_window():set_position((screen.width - width) / 2, (screen.height - height) / 2)
    window:gui_window():set_inner_size(width, height)
  end
end)

-- and finally, return the configuration to wezterm
return config
