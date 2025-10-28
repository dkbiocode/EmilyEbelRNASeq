#!/usr/bin/env bash
#SBATCH --partition=day-long-cpu
#SBATCH --job-name=hisatBuildCxT
#SBATCH --output=%x.%j.out
#SBATCH --time=1:30:00
#SBATCH --qos=normal
#SBATCH --nodes=1
#SBATCH --ntasks=24
source $HOME/templates/common.rc
echo "Using ${SLURM_NTASKS:=0} SLURM_NTASKS"
conda_activate ebel

# prepared input files
FA=HisatBaseFiles/Culex-tarsalis_knwr_CONTIGS_CtarK1.fa
SS=HisatBaseFiles/CtarK1.ss 
EXON=HisatBaseFiles/CtarK1.exon 

# command
cmd="hisat2-build -p $SLURM_NTASKS --exon $EXON --ss $SS $FA HisatIndices/CxT"
echo $cmd
time eval $cmd

