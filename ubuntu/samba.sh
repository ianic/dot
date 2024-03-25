#!/usr/bin/env sh

sudo apt install -y samba
samba -V

# add to:
# /etc/samba/smb.conf
[home]
path = /home/ianic
read only = no
writable = yes
guest ok = yes
browseable = yes

sudo smbpasswd -a ianic
sudo ufw allow samba
sudo systemctl restart samba
