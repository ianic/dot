#! /bin/bash

# Compton, killing compton resets kyboard variant (mac) somehove
# keep it before keyboard configuration
# killall compton
compton --config ~/.config/i3/compton.conf -b

# Set wallpaper
feh --bg-scale ~/.config/dot/wallpaper/big_sur_road.jpg

# Keyboard repeat rate
xset r rate 300 30

# Host dependent keyboard configs
case $(hostname) in
  thinkpad)
      # Replaces caps lock with control, use "ctrl:swapcaps" to swap capslock and control
      setxkbmap -layout us -option "ctrl:nocaps,altwin:swap_alt_win"
      xmodmap ~/.config/dot/ubuntu/Xmodmap
      # map PrtSc to alt
      # xmodmap -pke usefull for showing all mappings
      xmodmap -e 'keycode 107 = Alt_R Meta_R Alt_R Meta_R'
      ;;
  io)
    if [[ ! -f ~/.Xmodmap ]] ; then
        link ~/.config/dot/ubuntu/Xresources ~/.Xresources
        sudo cp ~/.config/dot/ubuntu/etc-default-keyboard /etc/default/keyboard
        sudo cp ~/.config/dot/ubuntu/01-fixkeyboard       /etc/dconf/db/ibus.d/
    fi

    # fix Ubuntu login screen scaling
    # fails with [org.gnome.desktop.interface]\nscaling-factor=2\n/usr/share/glib-2.0/schemas/93_hidpi.gschema.override: Key file does not start with a group.  Ignoring this file.
    dpi_fix=/usr/share/glib-2.0/schemas/93_hidpi.gschema.override
    if [[ ! -f  $dpi_fix ]]; then
        echo "[org.gnome.desktop.interface]\nscaling-factor=2" | sudo tee -a $dpi_fix
        sudo glib-compile-schemas /usr/share/glib-2.0/schemas
    fi

      setxkbmap  -layout "us" -model "macbook79"  -option "ctrl:nocaps"
      # Monitor resolution
      xrandr --output Virtual-1 --mode 6720x3780
      /usr/bin/prlcc &
      ;;
  hydra)
      # Fix mouse cursor size
      xrdb ~/.config/dot/ubuntu/hydra/Xresources
      # Fix ~,§  map caps to to control
      setxkbmap -layout "us(mac)" -model "macbook79" -option "ctrl:nocaps"
      # Fix right alt, must be after setxkbmap
      xmodmap .config/dot/ubuntu/hydra/Xmodmap

      # /usr/libexec/gsd-xsettings &
      ;;
  *)
      echo else
      ;;
esac

# Barrier
# Configuration is in /home/ianic/.local/share/barrier/.barrier.conf
# logs are visibel with: journalctl -f --user
/usr/bin/barriers --debug INFO --name hydra --disable-crypto --disable-client-cert-checking --config ~/.config/dot/ubuntu/barrier.conf
