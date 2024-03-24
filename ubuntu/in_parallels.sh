#! /bin/bash

# Keyboard
xset r rate 300 30

# Replaces caps lock with control, use "ctrl:swapcaps" to swap capslock and control
case $(hostname) in
  thinkpad)
      xmodmap ~/.config/dot/ubuntu/Xmodmap
      setxkbmap -layout us -option "ctrl:nocaps,altwin:swap_alt_win"
      ;;
  io)
      setxkbmap  -layout "us" -model "macbook79"  -option "ctrl:nocaps"
      # Monitor resolution
      xrandr --output Virtual-1 --mode 6720x3780
      ;;
  *)
      echo else
      ;;
esac

# Set wallpaper
feh --bg-scale ~/.config/dot/wallpaper/big_sur_road.jpg

# Compton
killall compton
compton --config ~/.config/i3/compton.conf -b


