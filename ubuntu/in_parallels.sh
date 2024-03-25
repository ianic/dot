#! /bin/bash

# Keyboard
xset r rate 300 30

# Replaces caps lock with control, use "ctrl:swapcaps" to swap capslock and control
case $(hostname) in
  thinkpad)
      setxkbmap -layout us -option "ctrl:nocaps,altwin:swap_alt_win"
      xmodmap ~/.config/dot/ubuntu/Xmodmap
      # map PrtSc to alt
      # xmodmap -pke usefull for showing all mappings
      xmodmap -e 'keycode 107 = Alt_R Meta_R Alt_R Meta_R'
      ;;
  io)
      setxkbmap  -layout "us" -model "macbook79"  -option "ctrl:nocaps"
      # Monitor resolution
      xrandr --output Virtual-1 --mode 6720x3780
      ;;
  hydra)
      setxkbmap -layout us -option "ctrl:nocaps"
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
