wgs_path = '/gpfs42/robbyfs/scratch/lab_lpasquali/msubirana/marc/insulinomas/data/WGS/BAM/INS/all_ok'
wes_path = '/gpfs42/robbyfs/scratch/lab_lpasquali/msubirana/marc/insulinomas/data/WES/BAM/all_bams'

wgs_files = list.files(wgs_path, full.names=TRUE, pattern='\\.bam$')
wes_files = list.files(wes_path, full.names=TRUE, pattern='\\.bam$')


wgs_files_tumor = wgs_files[grepl('_TI', wgs_files)]
wgs_files_ctrl = wgs_files[grepl('_BL', wgs_files)]
wgs_samples=gsub('_TI.bam', '', basename(wgs_files_tumor))

df_wgs=data.frame(sample=wgs_samples,tumor=wgs_files_tumor,ctrl=wgs_files_ctrl,experiment='wgs')


wes_files_tumor = wes_files[grepl('_TI', wes_files)]
wes_files_ctrl = wes_files[grepl('_BL', wes_files)]
wes_samples=gsub('_TI.bam', '', basename(wes_files_tumor))

df_wes=data.frame(sample=wes_samples,tumor=wes_files_tumor,ctrl=wes_files_ctrl,experiment='wes')

df_all = rbind(df_wgs, df_wes)

write.csv(df_all, file='../../conf/samples.csv', quote=FALSE, row.names=FALSE)
