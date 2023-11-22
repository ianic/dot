#!/bin/sh

prlcc &

xset r rate 300 30
xrandr -s 6720x3732

xmodmap -e "clear mod5"
xmodmap -e "keycode 108 = Alt_L"

# Fire it up
# exec dbus-launch --exit-with-session /snap/bin/emacs -mm --debug-init
exec /snap/bin/emacs -mm
