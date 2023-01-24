#!/bin/env bash

outdir=$1
exclude=$2
name=$3
fasta=$4
bam=$5

smoove call --outdir $outdir --exclude $exclude \
    -name $name --fasta $fasta -p 1 --genotype $bam