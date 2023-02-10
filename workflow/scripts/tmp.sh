#!/bin/bash
#SBATCH -n 8
#SBATCH --mem 8000
#SBATCH --partition=haswell

module load INSurVeyor/1.0.1-Singularity-3.8.7-GCCcore-11.2.0
module load bcftools/1.3.1
module load SAMtools/1.12-GCCcore-8.2.0
module load picard/2.25.5-Java-11

insurveyor_py="singularity run  $SINGULARITY_IMAGES/insurveyor.sif"
picard='java -jar $EBROOTPICARD/picard.jar'
threads=$1
tumor=$2
ctrl=$3
workdir=$4
reference=$5
sample=$6

workdir=${workdir}/insurveyor
mkdir -p $workdir

workdir=${workdir}/${sample}
mkdir -p $workdir

java -jar $EBROOTPICARD/picard.jar FixMateInformation I=${tumor}
java -jar $EBROOTPICARD/picard.jar FixMateInformation I=${ctrl}

samtools index ${tumor}
samtools index ${ctrl}

workdir_tumor=${workdir}/tumor
workdir_ctrl=${workdir}/ctrl

mkdir -p $workdir_tumor $workdir_ctrl

$insurveyor_py --threads $threads $tumor $workdir_tumor $reference
$insurveyor_py --threads $threads $ctrl $workdir_ctrl $reference

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
