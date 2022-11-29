#!/bin/env bash
set -u
install_dir=$1
gridss_version=$2
# TODO make version a input parameter

install_dir=${install_dir}/gridss
mkdir $install_dir
wget https://github.com/PapenfussLab/gridss/releases/download/v$gridss_version/gridss-$gridss_version-gridss-jar-with-dependencies.jar -O $install_dir/gridss-$gridss_version-gridss-jar-with-dependencies.jar
wget https://github.com/PapenfussLab/gridss/blob/master/example/ENCFF356LFX.bed -O $install_dir/exclude_list.bed
