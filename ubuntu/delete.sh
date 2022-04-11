#!/bin/bash -ex

host=${1:-no_host_name}

multipass info $host
multipass delete foo && multipass purge && rm ~/.ssh/config.d/foo
