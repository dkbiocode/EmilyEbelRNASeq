#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=00:10:00
#SBATCH --job-name=multiqc
#SBATCH --partition=short-cpu
#SBATCH --output=%x.%j.log # gives jobname.ID.log
# Available partitions
# day-long-cpu
# day-long-gpu
# day-long-highmem
# exp-gpu
# short-cpu*
# short-gpu
# short-highmem
# week-long-cpu
# week-long-gpu
# week-long-highmem
source $HOME/templates/common.rc
conda_activate ebel

cmd="multiqc --export --outdir DeDupMultiQC --title emily_WNV DeDupFastq{HTML,JSON}s"
echo $cmd
time eval $cmd
