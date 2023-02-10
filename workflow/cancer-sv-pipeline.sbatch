#!/bin/bash
# Main snakemake job:
# Submits snakemake jobs as individual slurm jobs
# =============================================================================
#SBATCH -p haswell 
#SBATCH --job-name=cancer-sv-pipeline
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --mem=8gb
#SBATCH --time=168:00:00 # Time limit hrs:min:sec
#SBATCH --output=/gpfs42/robbyfs/scratch/lab_lpasquali/msubirana/marc/cancer-sv-prove/logs/cancer-sv-pipeline.out
#SBATCH --error=/gpfs42/robbyfs/scratch/lab_lpasquali/msubirana/marc/cancer-sv-prove/logs/cancer-sv-pipeline.err
# =============================================================================
module load Miniconda3/4.9.2
source activate snakemake

cd /gpfs42/robbyfs/scratch/lab_lpasquali/msubirana/mtormo/cancer-sv-pipeline/workflow

snakemake -s Snakefile \
          --use-conda --conda-frontend mamba \
          --cluster-config conf/cluster-config.yaml \
          --latency-wait 5 \
          --cluster "sbatch -J {cluster.job-name} \\
                            -t {cluster.time} \\
                            -N {cluster.nodes} \\
                            -n {cluster.ntasks} \\
                            -p {cluster.partition} \\
                            --mem={cluster.mem} \\
                            --output {cluster.output} \\
                            --error {cluster.error}" \
          --jobs 4 --cores 8