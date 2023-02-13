#!/bin/env bash

insurveyor_py=$1
threads=$2
tumor=$3
ctrl=$4
workdir=$5
reference=$6
sample=$7

workdir=${workdir}/insurveyor
mkdir -p $workdir

workdir=${workdir}/${sample}
mkdir -p $workdir

# picard FixMateInformation I=${tumor} TMP_DIR=${workdir}
# picard FixMateInformation I=${ctrl} TMP_DIR=${workdir}

# rm -rf ${tumor}.bai
# samtools index ${tumor}

# rm -rf ${ctrl}.bai
# samtools index ${ctrl}

workdir_tumor=${workdir}/tumor
workdir_ctrl=${workdir}/ctrl

mkdir -p $workdir_tumor $workdir_ctrl

python3 $insurveyor_py --threads $threads $tumor $workdir_tumor $reference
python3 $insurveyor_py --threads $threads $ctrl $workdir_ctrl $reference

mv ${workdir_tumor}/out.pass.vcf.gz ${workdir_tumor}/${sample}_pass.vcf.gz
mv ${workdir_ctrl}/out.pass.vcf.gz ${workdir_ctrl}/${sample}_pass.vcf.gz 
mv ${workdir_tumor}/out.pass.vcf.gz.tbi ${workdir_tumor}/${sample}_pass.vcf.gz.tbi
mv ${workdir_ctrl}/out.pass.vcf.gz.tbi ${workdir_ctrl}/${sample}_pass.vcf.gz.tbi

workdir_tumor_ctrl=${workdir}/tumor_ctrl
mkdir -p workdir_tumor_ctrl

bcftools isec -p $workdir_tumor_ctrl -Oz ${workdir_tumor}/${sample}_pass.vcf.gz ${workdir_ctrl}/${sample}_pass.vcf.gz 

mv $workdir_tumor_ctrl/0000.vcf.gz $workdir_tumor_ctrl/${sample}_pass.vcf.gz
mv $workdir_tumor_ctrl/0000.vcf.gz.tbi $workdir_tumor_ctrl/${sample}_pass.vcf.gz.tbi
rm -rf $workdir_tumor_ctrl/0001.vcf.gz* 
rm -rf $workdir_tumor_ctrl/0002.vcf.gz* 
rm -rf $workdir_tumor_ctrl/0003.vcf.gz*
rm -rf $workdir_tumor_ctrl/README.txt

echo 'INSurVeyor finished ' ${sample}




# bam=/gpfs42/robbyfs/scratch/lab_lpasquali/msubirana/marc/insulinomas/data/WES/BAM/all_bams/NET101_TI.bam
# reference=/gpfs42/robbyfs/scratch/lab_lpasquali/msubirana/ref/GCA_000001405.15_GRCh38_no_alt_analysis_set.fa
# workdir_tumor=/gpfs42/robbyfs/scratch/lab_lpasquali/msubirana/marc/insulinomas/insurveyor/insurveyor/${sample}/tumor

# threads=1
# sample=NET101
# bam=/main/marc/insulinomas/data/WES/BAM/all_bams/NET101_TI.bam
# workdir_tumor=/main/marc/insulinomas/insurveyor/insurveyor/${sample}/tumor
# reference=/main/ref/GCA_000001405.15_GRCh38_no_alt_analysis_set.fa

# singularity run --bind /gpfs42/robbyfs/scratch/lab_lpasquali/msubirana/:/main $SINGULARITY_IMAGES/insurveyor.sif \
# --threads $threads $bam $workdir_tumor $reference

