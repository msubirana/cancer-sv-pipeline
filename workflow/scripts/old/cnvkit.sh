#!/bin/env bash

reference=$1
refFlat=$2
normal_bams=$3
tumor_bams=$4
threads=$5
out_path=$6

out_path = ${out_path}/cnvkit
out_ref_cnn=${out_path}/cnvkit/ref_cnn.cnn

mkdir -p $out_path

cnvkit.py batch \
$tumor_bams \
-n $normal_bams \
-m wgs \
-f $reference \
--annotate $refFlat \
--drop-low-coverage \
--output-reference $out_ref_cnn \
--output-dir $out_path \
--diagram --scatter \
-p $threads

touch ${out_path}/cnvkit/finished.txt
