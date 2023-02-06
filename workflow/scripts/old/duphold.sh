#!/bin/env bash
duphold=$1
vcf=$2
bam=$3
reference=$4
output=$5
threads=$6

$duphold -v $vcf -b $bam -f $reference -o ${output}.tmp -t ${threads}
# change the condition excusion del > 0.7 | dup < 1.3
bcftools view -e '(SVTYPE = "DEL" & DHFFC > 0.7) | (SVTYPE = "DUP" & DHBFC < 1.3)' ${output}.tmp > $output
rm -rf ${output}.tmp


