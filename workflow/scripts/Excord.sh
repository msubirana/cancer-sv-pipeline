#!/bin/env bash
set -u

tumor_bam=$1
reference=$2
out_bed=$3
excord=$4


samtools view -b $tumor_bam \
| ${excord} \
    --discordantdistance 500 \
    --fasta ${reference} \
    /dev/stdin \
| LC_ALL=C sort --buffer-size 2G -k1,1 -k2,2n -k3,3n \
| bgzip -c > $out_bed
