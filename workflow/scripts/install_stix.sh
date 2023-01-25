#!/bin/env bash
set -u
install_dir=$1
giggle_path=$2

echo $giggle_path

wget http://www.sqlite.org/2017/sqlite-amalgamation-3170000.zip  -O ${install_dir}/sqlite-amalgamation-3170000.zip
unzip ${install_dir}/sqlite-amalgamation-3170000.zip -d ${install_dir} && rm -rf ${install_dir}/sqlite-amalgamation-3170000.zip

wget https://github.com/ryanlayer/stix/archive/refs/heads/master.zip -O ${install_dir}/stix.zip
unzip ${install_dir}/stix.zip -d ${install_dir} && rm -rf ${install_dir}/stix.zip
make -C $install_dir/stix-master && mv ${install_dir}/stix-master/* ${install_dir}/stix && rm -rf ${install_dir}/stix-master