#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=03:00:00
#SBATCH --qos=normal
#SBATCH --partition=day-long-cpu
#SBATCH --job-name=hscountArrayCulex
#SBATCH --output=%x.%A-%a.log # gives slurm.ID.log
source $HOME/templates/common.rc
echo "Using SLURM_NTASKS=${SLURM_NTASKS:=0} SLURM_NTASKS"
echo "Running SLURM_ARRAY_TASK_ID=${SLURM_ARRAY_TASK_ID:=5}"
conda_activate ebel


BAMLIST=bamFileList.txt
GTF=../02_Hisat2/HisatBaseFiles/mrna_filtered.gtf

linenum=0
while read -r line
do
    if [ $SLURM_ARRAY_TASK_ID -eq $linenum ]
    then
      echo "line $linenum: $line"
      pref=hsCountsConcordantCxt/$(basename $line)
      suff=${pref/.bam/.HSCounts.txt}
      echo pref=${pref}
      echo suff=${suff}
      cmd="htseq-count --stranded=yes $line $GTF > $suff"
      echo $cmd
      time eval $cmd

      break
    fi
    linenum=$((linenum + 1))
done < $BAMLIST
