#!/bin/bash -ex

# nats-server install
# releases page: https://github.com/nats-io/nats-server/releases
nats_version=2.8.1
wget -q https://github.com/nats-io/nats-server/releases/download/v$nats_version/nats-server-v$nats_version-arm64.deb 2>&1
sudo dpkg -i nats-server-v$nats_version-arm64.deb
rm nats-server-v$nats_version-arm64.deb
nats-server --version

# natscli install
# https://github.com/nats-io/natscli/releases
natscli_version=0.0.32
wget -q https://github.com/nats-io/natscli/releases/download/v$natscli_version/nats-$natscli_version-arm64.deb 2>&1
sudo dpkg -i nats-$natscli_version-arm64.deb
rm nats-$natscli_version-arm64.deb
nats --version

# systemd configuration
cd ~
sudo mkdir -p /etc/nats.d
sudo mkdir -p /opt/nats
cat >nats.service <<EOF
[Unit]
After=network-online.target

[Service]
ExecStart=/usr/bin/nats-server -c=/etc/nats.d/nats.conf
KillMode=process
Restart=always
RestartSec=5s
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF
sudo mv nats.service /usr/lib/systemd/system

# server configuration
cat >nats.conf <<EOF
http_port: 8222

websocket {
   port: 9222
   no_tls: true
}

jetstream {
   store_dir=/opt/nats
}
EOF
sudo mv nats.conf /etc/nats.d/

# start nats
sudo systemctl enable nats
sudo systemctl start nats
