#!/bin/env bash

vcf=$1
output=$2

gridss_somatic_filter \
  --input $vcf \
  --output $output \

zcat ${output}.bgz > $output

echo 'Filtered ' ${vcf}

gridss_somatic_filter --input /home/msubirana/Documents/phd/repos/cancer-sv-pipeline/results/gridss/NET25.vcf --output /home/msubirana/Documents/phd/repos/cancer-sv-pipeline/results/gridss/NET25_pass.vcf.gz

scripts/gridss_somatic_filter.sh  