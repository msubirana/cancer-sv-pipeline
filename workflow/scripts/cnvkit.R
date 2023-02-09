#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

reference=args[1]
refFlat=args[2]
samples_csv=args[3]
threads=args[4]
out_path=args[5]

reference='/mnt/lp-lab1/refs/GCA_000001405.15_GRCh38_no_alt_analysis_set/GCA_000001405.15_GRCh38_no_alt_analysis_set.fa'
refFlat='data/refFlat.txt'
samples_csv='conf/samples.csv'
threads=1
out_path='/home/msubirana/Documents/phd/repos/cancer-sv-pipeline/results'
access_excludes='data/access-excludes.hg38.bed'
exomes_hg38='data/exons.bed'

out_path = file.path(out_path, 'cnvkit')
dir.create(out_path, showWarnings = FALSE)
out_ref_cnn = file.path(out_path, 'ref_cnn.cnn')

df_samples = read.csv(samples_csv)
normal_bams = paste0(df_samples$ctrl[df_samples$experiment=='wgs'], collapse=' ')
tumor_bams = paste0(df_samples$tumor[df_samples$experiment=='wgs'], collapse=' ')

paste('cnvkit.py batch',
tumor_bams,
'-n', normal_bams,
'-f', reference,
'-m wgs',
'--drop-low-coverage',
'--annotate', refFlat,
'--output-reference', out_ref_cnn,
'--output-dir', out_path,
'--diagram --scatter',
'-p', threads)

file.create(file.path(out_path, 'finished.txt'))

message('Cnvkit finished')
