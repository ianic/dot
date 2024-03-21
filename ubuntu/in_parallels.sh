#! /bin/bash

# Keyboard
xset r rate 300 30
# Replaces caps lock with control, use "ctrl:swapcaps" to swap capslock and control
setxkbmap -model "macbook79" -layout us  -option "ctrl:nocaps"

# Monitor resolution
xrandr --output Virtual-1 --mode 6720x3780

# Set wallpaper
feh --bg-scale ~/.config/dot/wallpaper/big_sur_road.jpg

# Compton
killall compton
compton --config ~/.config/i3/compton.conf -b
