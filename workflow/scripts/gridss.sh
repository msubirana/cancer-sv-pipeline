#!/bin/env bash

reference=$1
dependencies=$2
output=$3
exclude=$4
normal_bam=$5
tumor_bam=$6

scripts/gridss $reference \
        $dependencies \
        $output \
        $exclude \ 
        $normal_bam \
        $tumor_bam