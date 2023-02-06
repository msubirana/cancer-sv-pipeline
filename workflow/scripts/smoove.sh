#!/bin/env bash

outdir=$1
exclude=$2
name=$3
fasta=$4
bam=$5

smoove call --genotype --duphold --outdir $outdir --exclude $exclude \
    -name $name --fasta $fasta -p 1 --genotype $bam


bcftools view -e '(SVTYPE = "DEL" & DHFFC > 0.7) | (SVTYPE = "DUP" & DHBFC < 1.3)' ${outdir}/${name}-smoove.genotyped.vcf.gz > ${outdir}/${name}_dup.vcf

bcftools filter \
                -O v \
                -o ${outdir}/${name}_pass.vcf \
                -i "FILTER == 'PASS'" \
                ${outdir}/${name}_dup.vcf

echo 'Smoove finished ' ${outdir}/${name}_pass.vcf
