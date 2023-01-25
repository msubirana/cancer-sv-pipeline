#!/bin/env bash
set -u

stix=$1
giggle_index=$2
out_stix=$3
ped=$4

$stix -i $giggle_index -p $ped -d $out_stix -c 3
