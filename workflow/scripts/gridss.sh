#!/bin/env bash

reference=$1
output=$2
exclude=$3
normal_bam=$4
tumor_bam=$5
threads=$6

wd="$(dirname -- $output)"

gridss -r $reference -o $output -w $wd -b $exclude $normal_bam $tumor_bam -t $threads # for some reason if it is not in one line gridss do not work

