#!/bin/bash -e

# ovo je za prebacivanje monitora
# ddcutil -d 1 setvcp xF4 x00D2 --i2c-source-addr=x50 --noverify

# solaar config "MX Keys Mac" change-host 1
# MX Keys Mac connected to bluetooth to channel 1
hidapitester --vidpid 046D:B361 --usage 0x0202 --usagePage 0xff43 --open --length 20 --send-output 0x11,0xFF,0x09,0x1e,0x00

#solaar config "MX Master 3S" change-host 2
# MX Master 3s connected by bluetooth to channel 1
hidapitester --vidpid 046D:B034 --usage 0x0202 --usagePage 0xff43 --open --length 20 --send-output 0x11,0xFF,0x0A,0x1c,0x00

# put current clipboard to Callisto clipboard
CMD="echo '$(xclip -selection clipboard -o)' | pbcopy" && ssh callisto $CMD
