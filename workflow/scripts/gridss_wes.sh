#!/bin/env bash

reference=$1
output=$2
exclude=$3
normal_bam=$4
tumor_bam=$5
threads=$6
script_ann=$7
sample=$8
CONFIGURATION_FILE=$9
duphold = $10

wd="$(dirname -- $output)"
output_gridss=${wd}/${sample}.vcf
output_ann=${wd}/${sample}_ann.vcf
output_dup=${wd}/${sample}_dup.vcf
output_pass=$output

gridss -r $reference -o $output_gridss -w $wd -b $exclude $normal_bam $tumor_bam -t $threads -c $CONFIGURATION_FILE # for some reason if it is not in one line gridss do not work

Rscript $script_ann $output_gridss $output_ann

$duphold -v $output_ann -b $tumor_bam -f $reference -o ${output_dup}.tmp -t ${threads}

bcftools view -e '(SVTYPE = "DEL" & DHFFC > 0.7) | (SVTYPE = "DUP" & DHBFC < 1.3)' ${output_dup}.tmp > ${output_dup}
rm -rf ${output_dup}.tmp

bcftools filter -O v -o $output_pass -i "FILTER == 'PASS'" $output_dup

echo 'Gridss finished ' $output_pass