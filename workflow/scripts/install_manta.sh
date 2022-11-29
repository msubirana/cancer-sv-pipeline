#!/bin/env bash
set -u
install_dir=$1
manta_version=$2
# TODO make version a input parameter

wget https://github.com/Illumina/manta/releases/download/v$manta_version/manta-$manta_version.centos6_x86_64.tar.bz2 -O $install_dir/manta.tar.bz2
tar -xjvf $install_dir/manta.tar.bz2 -C $install_dir && 
    rm $install_dir/manta.tar.bz2
