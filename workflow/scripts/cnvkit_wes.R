#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

reference=args[1]
refFlat=args[2]
samples_csv=args[3]
threads=args[4]
out_path=args[5]
access_excludes=args[6]
exomes_hg38=args[7]

out_path = file.path(out_path, 'cnvkit_wes')
dir.create(out_path, showWarnings = FALSE)
out_ref_cnn = file.path(out_path, 'ref_cnn.cnn')

df_samples = read.csv(samples_csv)
normal_bams = paste0(df_samples$ctrl[df_samples$experiment=='wes'], collapse=' ')
tumor_bams = paste0(df_samples$tumor[df_samples$experiment=='wes'], collapse=' ')

system(paste('cnvkit.py batch',
tumor_bams,
'-n', normal_bams,
'-f', reference,
'-t', exomes_hg38,
'--access', access_excludes,
'--annotate', refFlat,
'--output-reference', out_ref_cnn,
'--output-dir', out_path,
'--diagram --scatter',
'-p', threads))

file.create(file.path(out_path, 'finished.txt'))

message('Cnvkit WES finished')