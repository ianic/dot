#!/bin/bash -ex
#
if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install libressl
else
    cd ~/src
    version=3.6.0
    wget https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-"$version".tar.gz
    tar -xf libressl-"$version".tar.gz
    ls -al
    cd libressl-"$version"/
    ./configure
    sudo make install
fi
