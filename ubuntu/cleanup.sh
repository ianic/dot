#!/bin/bash -e

CN='\033[0;32m'
NC='\033[0m' # No Color

# cleanup
printf "${CN}cleanup ~/.vscode-server-insiders${NC}\n"
cd ~/.vscode-server-insiders/cli/servers && ls -1t | tail -n +3 | xargs rm -rf
cd ~/.vscode-server-insiders/bin && ls -1t | tail -n +2 | xargs rm -rf
cd ~/.vscode-server-insiders/ && ls -1t code-insider* | tail -n +2 | xargs rm -f
cd ~/.vscode-server-insiders/data/User/workspaceStorage && ls -1t . | tail -n +10 | xargs rm -rf

printf "${CN}cleanup /usr/local/zig${NC}\n"
cd /usr/local/zig && ls -1td *-dev.* | tail -n +3 | xargs sudo rm -rf

printf "${CN}home${NC}\n"
cd ~
du -h -d1

# restore:
#rsync -av ~/code/bkp/zig ~
#mkdir -p ~/go
#rsync -av ~/code/bkp/go/src ~/go
