 #!/bin/bash

rundir=$1
threads=$2
output_manta=$3
tumor=$4
reference=$5
sample=$6
outdir=$7
duphold=$8

output_dup=${outdir}/${sample}_dup.vcf
output_pass=${outdir}/${sample}_pass.vcf

$rundir -m local -j $threads --quiet

$duphold -v $output_manta -b $tumor -f $reference -o ${output_dup}.tmp -t ${threads}

bcftools view -e '(SVTYPE = "DEL" & DHFFC > 0.7) | (SVTYPE = "DUP" & DHBFC < 1.3)' ${output_dup}.tmp > ${output_dup}
rm -rf ${output_dup}.tmp

bcftools filter -O v -o $output_pass -i "FILTER == 'PASS'" $output_dup

echo 'Manta finished ' $output_pass

