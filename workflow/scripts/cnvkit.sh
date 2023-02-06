#!/bin/env bash

reference=$1
refFlat=$2
out_ref_cnn=$3
normal_bams=$4
tumor_bams=$5
threads=$6
out_path=$7

out_path = ${out_path}/cnvkit

mkdir $out_path

cnvkit.py batch \
$tumor_bams \
-n $normal_bams \
-m wgs \
-f $reference \
--annotate $refFlat \
--drop-low-coverage \
--output-reference $out_ref_cnn \
--output-dir $out_path \
--diagram --scatter
-p $threads

touch ${out_path}/finished.txt

