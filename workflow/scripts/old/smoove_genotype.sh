#!/bin/env bash

name=$1
outdir=$2
fasta=$3
vcf=$4
bam=$5

smoove genotype -d -x -p 1 --name $name -outdir $outdir \
--fasta $fasta --vcf $vcf $bam