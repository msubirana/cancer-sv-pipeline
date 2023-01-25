#!/bin/env bash
set -u
install_dir=$1

wget https://github.com/ryanlayer/giggle/archive/refs/heads/master.zip -O ${install_dir}/giggle.zip
unzip ${install_dir}/giggle.zip -d ${install_dir} && rm ${install_dir}/giggle.zip
make -C $install_dir/giggle-master && mv ${install_dir}/giggle-master/* ${install_dir}/giggle && rm -rf ${install_dir}/giggle-master