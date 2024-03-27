#!/usr/bin/env sh

# Keyboard repeat rate
xset r rate 300 30

# Fix ~,§  map caps to to control
setxkbmap -layout "us(mac)" -model "macbook79" -option "ctrl:nocaps"
# Fix right alt, must be after setxkbmap
xmodmap .config/dot/ubuntu/hydra/Xmodmap

# Start barrier server
/usr/bin/barriers --debug INFO --name hydra --disable-crypto --disable-client-cert-checking
