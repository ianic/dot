local wezterm = require 'wezterm'
local act = wezterm.action

-- function set_background(window, pane)
--   local domain_name = pane:get_domain_name()  
--   if  domain_name == "local" then 
--     window:set_config_overrides({ window_background_image = "/Users/ianic/Pictures/thinkpad.jpeg" })
--   else 
--     window:set_config_overrides({ window_background_image = "/Users/ianic/Pictures/dev2.jpg" })
--   end
-- end

-- wezterm.on('window-focus-changed', function(window, pane)
--   wezterm.log_info('window-focus-changed', pane:get_domain_name(), window)
--   set_background(window, pane)
-- end)

-- wezterm.on('update-status', function(window, pane)
--   wezterm.log_info('update_status', pane:get_domain_name())
--   set_background(window, pane)
-- end)

-- wezterm.on(
--   'new-tab-button-click',
--   function(window, pane, button, default_action)
--     -- just log the default action and allow wezterm to perform it
--     wezterm.log_info('new-tab', window, pane, button, default_action)
--   end
-- )

return {
  --term = "wezterm",
  --term = "ansi",
  use_ime = false,
  use_dead_keys = false,
  send_composed_key_when_left_alt_is_pressed = false,
  send_composed_key_when_right_alt_is_pressed = false,
  --hide_tab_bar_if_only_one_tab = true,
  --disable_default_key_bindings = true,
  tab_bar_at_bottom = true,
  show_new_tab_button_in_tab_bar = false,
  --enable_tab_bar = false,

  font = wezterm.font 'JetBrains Mono',
  font_size = 15,
  --font = wezterm.font 'SauceCodePro Nerd Font Mono',
  --font = wezterm.font 'Hack Nerd Font Mono',
  --font = wezterm.font 'Meslo LG M DZ for Powerline',

  --color_scheme = 'Batman',
  -- color_scheme = "Dracula (Official)",
  color_scheme = "nord",  
  --color_scheme = 'Google (light) (terminal.sexy)',
  --
  -- native_macos_fullscreen_mode = true,
  window_background_image = "/Users/ianic/Pictures/10-15-Night.jpg",
  --window_background_image = '/Users/ianic/Pictures/Big Sur Road.jpg',
  --window_background_image = '/Users/ianic/Pictures/Catalina Clouds.jpg',
  window_background_image_hsb = {
    -- Darken the background image 
    brightness = 0.2,
    -- You can adjust the hue by scaling its value.
    -- a multiplier of 1.0 leaves the value unchanged.
    hue = 1.0,
    -- You can adjust the saturation also.
    saturation = 0.5,
  },
  inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.7,
},

use_fancy_tab_bar = false,
colors = {
  tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
    background = '#000000',

    active_tab = {
      bg_color = '#272C36',
      fg_color = '#c0c0c0',
    },

    inactive_tab = {
      bg_color = '#000000',
      fg_color = '#808080',
      --strikethrough = true,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab`.
    },
  }
},

default_cursor_style = 'BlinkingBar',
cursor_thickness = 4,
cursor_blink_rate = 500,
  window_padding = {
   	left = 0,
	right = 0,
    top = 0,
    bottom = 0,
  },
  --  enable_scroll_bar = false,

  --leader = { key = 'x', mods = 'CTRL', timeout_milliseconds = 1000 },


  keys = {
    {
       key = '-',
       mods = 'CTRL',
       action = wezterm.action.DisableDefaultAssignment
    },
    {
       key = '=',
       mods = 'CTRL',
       action = wezterm.action.DisableDefaultAssignment
    },
    {
      key = 'd',
      mods = 'SUPER',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'd',
      mods = 'SUPER|SHIFT',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'w',
      mods = 'SUPER',
      --action = wezterm.action.CloseCurrentPane{confirm=true},
      action = wezterm.action.DisableDefaultAssignment
    },
    {
      key = 'w',
      mods = 'SUPER|SHIFT',
      action = wezterm.action.CloseCurrentPane{confirm=true},
    },

    {
      key = 'K',
      mods = 'SUPER',
      action = act.SendString 'clear\n',
    },
    {
      key = 'k',
      mods = 'SUPER',
      action = act.ResetTerminal,
    },
    {
      key = 'Enter',
      mods = 'SUPER|SHIFT',
      action = wezterm.action.TogglePaneZoomState,
    },
    {
      key = '[',
      mods = 'SUPER',
      action = act.ActivatePaneDirection 'Prev',
    },
    {
      key = ']',
      mods = 'SUPER',
      action = act.ActivatePaneDirection 'Next',
    },
    {
      key = 'o',
      mods = 'SUPER',
      action = act.PaneSelect {  },
    },

  {
    key = 'LeftArrow',
    mods = 'SUPER',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'RightArrow',
    mods = 'SUPER',
    action = act.ActivatePaneDirection 'Right',
  },
  {
    key = 'UpArrow',
    mods = 'SUPER',    
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'DownArrow',
    mods = 'SUPER',        
    action = act.ActivatePaneDirection 'Down',
  },


--    {
--      key = '2',
--      mods = 'LEADER',
--      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
--    },
--    {
--      key = '3',
--      mods = 'LEADER',
--      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
--    },
--    {
--      key = 'o',
--      mods = 'LEADER',
--      action = act.PaneSelect {  },
--    },
--    {
--      key = 'k',
--      mods = 'LEADER',
--      action = act.CloseCurrentPane { confirm=true },
--    },
--    {
--      key = '0',
--      mods = 'LEADER',
--      action = act.TogglePaneZoomState,
--    },
--    {
--      key = '1',
--      mods = 'LEADER',
--      action = act.TogglePaneZoomState,
--    },
  },
}
