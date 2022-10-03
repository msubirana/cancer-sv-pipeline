#!/bin/env bash
set -u
install_dir=$1
outdir=$2

# TODO make version a input parameter
manta_version=1.6.0
wget https://github.com/Illumina/manta/releases/download/v$manta_version/manta-$manta_version.centos6_x86_64.tar.bz2 -O $outdir/manta.tar.bz2
tar -xjvf $outdir/manta.tar.bz2  && 
    rm $outdir/manta.tar.bz2 &&
    mv manta-$manta_version.centos6_x86_64 $install_dir
