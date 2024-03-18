#! /bin/bash

# Keyboard
xset r rate 300 30
setxkbmap -model "macbook79" -layout us  -option "ctrl:swapcaps"

# Monitor resolution
xrandr --output Virtual-1 --mode 6720x3780

# Removes icon (keyboard switch) EN from top right
killall ibus-ui-gtk3

# Set wallpaper
feh --bg-scale ~/host/Pictures/Big\ Sur\ Road.jpg

# Compton
killall compton
compton --config ~/.config/i3/compton.conf -b
