#!/bin/env bash
set -u
install_dir=$1
gridss_version=$2
# TODO make version a input parameter

wget https://github.com/PapenfussLab/gridss/releases/download/v$gridss_version/gridss-$gridss_version-gridss-jar-with-dependencies.jar -O $install_dir/gridss-$gridss_version-gridss-jar-with-dependencies.jar
wget https://raw.githubusercontent.com/PapenfussLab/gridss/master/example/ENCFF356LFX.bed -O $install_dir/exclude_list.bed

