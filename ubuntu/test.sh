#!/bin/bash -ex

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo SCRIPT_DIR = $SCRIPT_DIR

cd ~
pwd

echo "${BASH_SOURCE}"

cd $(dirname "${BASH_SOURCE[0]}" ) # this script dir
pwd

echo "The bash script path is $(dirname -- "$(readlink -f – "$0")";)";
