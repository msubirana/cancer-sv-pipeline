#!/bin/env bash
set -u
install_dir=$1
excord_version=$2

wget https://github.com/brentp/excord/releases/download/v${excord_version}/excord -O $install_dir/excord
chmod 777 $install_dir/excord

