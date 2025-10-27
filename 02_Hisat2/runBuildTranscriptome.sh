#!/usr/bin/env bash
#SBATCH --partition=day-long-cpu
#SBATCH --job-name=hisatBuildCxT
#SBATCH --output=%x.%j.out
#SBATCH --time=1:30:00
#SBATCH --qos=normal
#SBATCH --nodes=1
#SBATCH --ntasks=24
source $HOME/templates/common.rc
conda_activate ebel
hisat2-build -p $SLURM_NTASKS --exon 68Genes.exon --ss 68Genes.ss AedesGenome68.fa AedesTranscriptome68
