#!/bin/env bash
set -u
install_dir=$1

wget https://github.com/MSBradshaw/SeeNV/archive/refs/heads/main.zip -O ${install_dir}/seenv.zip
unzip ${install_dir}/seenv.zip -d ${install_dir} && rm ${install_dir}/seenv.zip
rm -rf SeeNV
mv ${install_dir}/SeeNV-main ${install_dir}/SeeNV
cd ${install_dir}/SeeNV
source install.sh


