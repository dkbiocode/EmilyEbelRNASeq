#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=100
#SBATCH --time=168:00:00
#SBATCH --qos=normal
#SBATCH --partition=week-long-cpu
#SBATCH --job-name=ConcordantAedesArrayHisat
#SBATCH --mail-user=$USER
#SBATCH --mail-type=all
#SBATCH --output=%x.%A-%a.log # gives slurm.ID.log

echo "[$0] $SLURM_JOB_NAME $@" # log the command line

module purge
source activate base
conda activate rnaPseudo

date # timestamp

filename=ConcordantAedesTrimmed.txt # $1

linenum=0
while read -r line
do
    if [ $SLURM_ARRAY_TASK_ID -eq $linenum ]
    then
      TWO=${line/_R1_/_R2_}
      OUT=${TWO:16:(${#TWO}-25)} #Remove trimmed, and end. 23 is 8 (trimmed.) + 15 (R1_001$
      echo ${TWO}
      echo $OUT
      hisat2 --phred33 --rna-strandness RF -p 100 -x AedesTranscriptome68 -1 ${line} -2 ${TWO} -S AeAeConcordant/$OUT.sam
    fi
    linenum=$((linenum + 1))
done < $filename
