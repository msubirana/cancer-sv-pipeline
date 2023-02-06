#!/bin/env bash

reference=$1
output_gridss=$2
tumor_bam=$3
threads=$4
script_ann=$5
sample=$6

wd="$(dirname -- $output)"
output_ann=${wd}/${sample}_ann.vcf
output_dup=${wd}/${sample}_dup.vcf
output_pass=${wd}/${sample}_pass.vcf

Rscript $script_ann $output_gridss $output_ann

duphold -v $output_ann -b $tumor_bam -f $reference -o ${output_dup}.tmp -t ${threads}

bcftools view -e '(SVTYPE = "DEL" & DHFFC > 0.7) | (SVTYPE = "DUP" & DHBFC < 1.3)' ${output_dup}.tmp > ${output_dup}
rm -rf ${output_dup}.tmp

bcftools filter -O v -o $output_pass -i "FILTER == 'PASS'" $output_dup

echo 'Gridss finished ' $output_pass