#!/usr/bin/env sh

# # Keyboard repeat rate
# xset r rate 300 30

# # Fix ~,§  map caps to to control
# setxkbmap -layout "us(mac)" -model "macbook79" -option "ctrl:nocaps"
# # Fix right alt, must be after setxkbmap
# xmodmap ~/.config/dot/ubuntu/hydra/Xmodmap

# Start barrier server
# /usr/bin/barriers --debug INFO --name hydra --disable-crypto --disable-client-cert-checking --config ~/.config/dot/ubuntu/barrier.conf

# Disable usb devices from waking up from suspend
# sudo sh -c 'echo XHCI > /proc/acpi/wakeup'


# Fix unable to resize windows after boot
# Ref: https://bugs.launchpad.net/ubuntu/+source/gtk+3.0/+bug/2064177
# $(sleep 5 && pkill -HUP mutter-x11-fram)
