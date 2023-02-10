#!/bin/env bash
set -u
install_dir=$1

wget https://github.com/MSBradshaw/SeeNV/archive/refs/heads/main.zip -O ${install_dir}/seenv.zip
unzip ${install_dir}/seenv.zip -d ${install_dir} && rm ${install_dir}/seenv.zip
rm -rf ${install_dir}/SeeNV
mv ${install_dir}/SeeNV-main ${install_dir}/SeeNV

wget https://github.com/brentp/gargs/releases/download/v0.3.9/gargs_linux -O ${install_dir}/SeeNV/bin/gargs
chmod 770 ${install_dir}/SeeNV/bin/gargs



