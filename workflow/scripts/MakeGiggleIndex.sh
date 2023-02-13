#!/bin/env bash
set -u

giggle=$1
excord_path=$2
output_giggle=$3

$giggle index -i ${excord_path}/´*gz´ -o $output_giggle -s -f
