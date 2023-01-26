#!/bin/env bash
set -u
install_dir=$1
duphold_version=$2

wget https://github.com/brentp/duphold/releases/download/v${duphold_version}/duphold -O $install_dir/duphold
chmod 777 $install_dir/duphold





