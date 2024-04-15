
#! /bin/bash

# MX Keys connected to bolt receiver channel 1 to channel 3
/Users/ianic/.local/bin/hidapitester --vidpid 046D:C52B --usage 0x0001 --usagePage 0xFF00 --open --length 7 --send-output 0x10,0x01,0x09,0x1e,0x2

# MX Master 3S connectet to bolt channel 1 to channel 3
/Users/ianic/.local/bin/hidapitester --vidpid 046D:C548 --usage 0x0001 --usagePage 0xFF00 --open --length 7 --send-output 0x10,0x02,0x0A,0x1e,0x2

# MX Master 3S connectet by bluetooth channel 1 to channel 0
# hidapitester --vidpid 046D:B034 --usage 0x0202 --usagePage 0xFF43 --open --length 20 --send-output 0x11,0x02,0x0A,0x1b,0x0

# put current clipboard to Callisto clipboard
CMD="echo '$(pbpaste)' > ~/.clipboard" && ssh hydra $CMD
