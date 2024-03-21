#!/bin/bash -e

host=$1

scp ~/.ssh/authorized_keys2 $host:~/.ssh
scp ~/.ssh/id_rsa           $host:~/.ssh
scp ~/.ssh/id_rsa.pub       $host:~/.ssh

ssh $host 'chmod 400 ~/.ssh/id_rsa; chmod 444 ~/.ssh/id_rsa.pub; chmod 600 ~/.ssh/authorized_keys2'
