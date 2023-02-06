#!/bin/env bash

reference=$1
output=$2
exclude=$3
normal_bam=$4
tumor_bam=$5
threads=$6
sample=$7
duphold=$8

wd="$(dirname -- $output)"
output_precall=${wd}/${sample}_precall.bcf
output_filter=${wd}/${sample}_filter.bcf
output_dup=${wd}/${sample}_dup.vcf
output_pass=$output
sample_tsv=${wd}/${sample}_samples.tsv

delly call -x $exclude -o $output_precall -g $reference $tumor_bam $normal_bam

bcftools query -l $output_precall > ${sample_tsv}.tmp
echo -e 'tumor\ncontrol' > ${sample_tsv}.tmp1
paste ${sample_tsv}.tmp ${sample_tsv}.tmp1 -d "\t" > ${sample_tsv}

delly filter -f somatic -o $output_filter -s $sample_tsv $output_precall

$duphold -v $output_filter -b $tumor_bam -f $reference -o ${output_dup}.tmp -t ${threads}

bcftools view -e '(SVTYPE = "DEL" & DHFFC > 0.7) | (SVTYPE = "DUP" & DHBFC < 1.3)' ${output_dup}.tmp > ${output_dup}
rm -rf ${output_dup}.tmp

bcftools filter -O v -o $output_pass -i "FILTER == 'PASS'" $output_dup

echo 'Delly finished ' $output_pass