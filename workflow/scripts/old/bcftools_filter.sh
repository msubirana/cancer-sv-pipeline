 #!/bin/bash
input_vcf=$1
output_vcf=$2

bcftools filter \
                -O v \
                -o $output_vcf \
                -i "FILTER == 'PASS'" \
                $input_vcf

echo 'Filtered ' ${input_vcf}



