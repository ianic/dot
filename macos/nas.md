
U /etc/hosts imam: 
192.168.190.250 nas

Dodao sam si authorized_keys na nas server u admin account:
scp ~/.ssh/authorized_keys2 admin@nas:~/.ssh/authorized_keys

Dodao sam si nas file u .ssh/config.d:

Host nas
  HostName 192.168.190.250
  User admin
  ForwardAgent yes

I onda ga mogu paliti gasiti from command line:

```sh
wakeonlan 00:08:9B:C9:1E:13

/usr/bin/ssh nas poweroff
```


References: 
https://discussions.apple.com/thread/250213563
https://tclementdev.com/timemachineeditor/


