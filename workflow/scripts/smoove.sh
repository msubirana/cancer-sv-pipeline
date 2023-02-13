#!/bin/env bash

outdir=$1
exclude=$2
name=$3
fasta=$4
bam=$5
duphold=$6
threads=$7

smoove call --outdir $outdir --exclude $exclude \
    --name $name --fasta $fasta -p 1 --genotype $bam

$duphold -v ${outdir}/${name}-smoove.genotyped.vcf.gz -b $bam -f $fasta -o ${outdir}/${name}_dup.vcf.tmp -t ${threads}

bcftools view -e '(SVTYPE = "DEL" & DHFFC > 0.7) | (SVTYPE = "DUP" & DHBFC < 1.3)' ${outdir}/${name}_dup.vcf.tmp > ${outdir}/${name}_dup.vcf

bcftools filter \
                -O v \
                -o ${outdir}/${name}_pass.vcf \
                -i "FILTER == 'PASS'" \
                ${outdir}/${name}_dup.vcf

echo 'Smoove finished ' ${name}


# smoove call --outdir /gpfs42/robbyfs/scratch/lab_lpasquali/msubirana/mtormo/cancer-sv-pipeline/workflow \
# --exclude /gpfs42/robbyfs/scratch/lab_lpasquali/msubirana/mtormo/cancer-sv-pipeline/workflow/data/exclude_list.bed --name NET25 \
# --fasta /gpfs42/robbyfs/scratch/lab_lpasquali/msubirana/ref/GCA_000001405.15_GRCh38_no_alt_analysis_set.fa \
# -p 1 --genotype /gpfs42/robbyfs/scratch/lab_lpasquali/msubirana/marc/cancer-sv-prove/data/NET25_TI.bam