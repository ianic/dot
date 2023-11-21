local wezterm = require 'wezterm'
local act = wezterm.action

function is_an_editor(name)
  return name:find("emacsclient") or name:find("emacs")
end

return {
  --ako zelis viditi sto ce napraviti na neku kombinaciju, koji je escape code, ukljuci:
  --debug_key_events = true,
  use_ime = false,
  use_dead_keys = false,
  send_composed_key_when_left_alt_is_pressed = false,
  send_composed_key_when_right_alt_is_pressed = false,

  tab_bar_at_bottom = true,
  show_new_tab_button_in_tab_bar = false,
  --enable_tab_bar = false,

  font = wezterm.font 'JetBrains Mono',
  font_size = 15,
  color_scheme = "nord",  
  window_background_image = "/Users/ianic/Pictures/10-15-Night.jpg",

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
    saturation = 0.1,
    brightness = 0.5,
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

  default_cursor_style = 'SteadyBlock',
  --cursor_thickness = 4,
  --cursor_blink_rate = 500,
  window_padding = {
    left = 0,
	right = 0,
    top = 0,
    bottom = 0,
  },

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
      action = wezterm.action_callback(function(window, pane)
          if is_an_editor(pane:get_title()) then
            window:perform_action(wezterm.action.DisableDefaultAssignment, pane)
          else
            window:perform_action(wezterm.action.CloseCurrentPane{confirm=true}, pane)
          end
      end)
      --action = wezterm.action.CloseCurrentPane{confirm=true},
      --action = wezterm.action.DisableDefaultAssignment
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
      action = wezterm.action_callback(function(window, pane)
          if is_an_editor(pane:get_title()) then
            window:perform_action({SendKey={key="[", mods="SUPER"}}, pane)
          else
            window:perform_action(wezterm.action.ActivatePaneDirection('Prev'), pane)
          end
      end)
      --act.ActivatePaneDirection 'Prev',
    },
    {
      key = ']',
      mods = 'SUPER',
      action = wezterm.action_callback(function(window, pane)
          if is_an_editor(pane:get_title()) then
            window:perform_action({SendKey={key="]", mods="SUPER"}}, pane)
          else
            window:perform_action(wezterm.action.ActivatePaneDirection('Next'), pane)
          end
      end)
      --action = act.ActivatePaneDirection 'Next',
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

    { key = 'p', mods = 'SHIFT|SUPER', action = act.SendKey({ key="p", mods="SUPER|SHIFT" }) },
    { key = 'o', mods = 'SHIFT|SUPER', action = act.SendKey({ key="o", mods="SUPER|SHIFT" }) },
  },
}
