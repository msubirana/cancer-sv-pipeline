#!/bin/env bash

reference=$1
refFlat=$2
samples_csv=$3
threads=$4
out_path=$5

out_path = ${out_path}/cnvkit_wes
mkdir -p $out_path
out_ref_cnn=${out_path}/cnvkit_wes/ref_cnn.cnn

cnvkit.py batch \
$tumor_bams \
-n $normal_bams \
-f $reference \
--annotate $refFlat \
--output-reference $out_ref_cnn \
--output-dir $out_path \
--diagram --scatter \
-p $threads

touch ${out_path}/cnvkit_wes/finished.txt

reference=/mnt/lp-lab1/refs/GCA_000001405.15_GRCh38_no_alt_analysis_set/GCA_000001405.15_GRCh38_no_alt_analysis_set.fa
exclude=data/exclude_list.bed
refFlat='data/refFlat.txt'
samples_csv='conf/samples.csv'
threads=1
out_path='/home/msubirana/Documents/phd/repos/cancer-sv-pipeline/results/cnv_wes'

out_path = ${out_path}/cnvkit_wes
mkdir -p $out_path
out_ref_cnn=${out_path}/cnvkit_wes/ref_cnn.cnn

cnvkit.py batch \
$tumor_bams \
-n $normal_bams \
-f $reference \
--annotate $refFlat \
--output-reference $out_ref_cnn \
--output-dir $out_path \
--diagram --scatter \
-p $threads

touch ${out_path}/cnvkit_wes/finished.txt