#!/usr/bin//env bash

#SBATCH --partition=day-long-cpu
#SBATCH --job-name=hisatBuildAedesTrans
#SBATCH --output=%x.%j.out
#SBATCH --time=1:30:00
#SBATCH --qos=normal
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haogg@colostate.edu

module purge
source activate base
conda activate rnaPseudo

hisat2-build -p 24 --exon 68Genes.exon --ss 68Genes.ss AedesGenome68.fa AedesTranscriptome68
