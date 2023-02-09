#!/bin/env bash

set -u
install_dir=$1

wget https://github.com/kensung-lab/INSurVeyor/archive/refs/heads/main.zip -O ${install_dir}/INSurVeyor.zip
unzip ${install_dir}/INSurVeyor.zip -d ${install_dir} && rm ${install_dir}/INSurVeyor.zip
rm -rf ${install_dir}/INSurVeyor
mv ${install_dir}/INSurVeyor-main ${install_dir}/INSurVeyor
cd ${install_dir}/INSurVeyor
./build_htslib.sh
cmake -DCMAKE_BUILD_TYPE=Release . && make


