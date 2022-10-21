#!/usr/bin/env sh

cd ~/code/nats.io/

echo nats-server
(cd nats-server && git pull) || (git clone git@github.com:nats-io/nats-server.git && cd nats-server)
(cd nats-server && go install)

echo nkeys
(cd nkeys && git pull) || (git clone git@github.com:nats-io/nkeys.git && cd nkeys)
(cd nkeys/nk && go install)

echo nats.go
(cd nats.go && git pull) || (git clone git@github.com:nats-io/nats.go.git && cd nkeys)
