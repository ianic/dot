#!/bin/bash -ex
#
# currently using 1.9.0 RC version from: https://github.com/canonical/multipass/issues/2511
# so I can get ubuntu 22.04 image

host=${1:-dev}

multipass launch -n $host -m 4G -c 4 -d 8G 22.04
multipass mount /Users/ianic/code $host:/home/ubuntu/code

# get IP of the new host
ip=$(multipass info $host --format json  | jq ".info.$host.ipv4[0]" -r)

# config my ssh
cat >~/.ssh/config.d/$host <<EOF
Host $host
  HostName $ip
  User ubuntu
  ForwardAgent yes
EOF

multipass transfer ~/.ssh/authorized_keys2 $host:/home/ubuntu/.ssh/authorized_keys2
multipass transfer ~/.ssh/id_rsa           $host:/home/ubuntu/.ssh/id_rsa
multipass transfer ~/.ssh/id_rsa.pub       $host:/home/ubuntu/.ssh/id_rsa.pub

ssh $host 'chmod 400 ~/.ssh/id_rsa'
ssh $host 'chmod 444 ~/.ssh/id_rsa.pub'
ssh $host 'chmod 600 ~/.ssh/authorized_keys2'


ssh $host 'bash -ex' < system.sh
ssh $host 'bash -ex' < nats.sh
ssh $host 'bash -ex' < zig.sh
