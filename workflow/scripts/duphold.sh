#!/bin/env bash
duphold=$1
vcf=$2
bam=$3
reference=$4
output=$5

$duphold -v $vcf -b $bam -f $reference -o $output
bcftools view -i '(SVTYPE = "DEL" & FMT/DHFFC[0] < 0.7) | (SVTYPE = "DUP" & FMT/DHBFC[0] > 1.3)' ${output}.tmp > $output
rm -rf ${output}.tmp
