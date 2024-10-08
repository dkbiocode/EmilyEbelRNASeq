#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=100
#SBATCH --time=120:00:00
#SBATCH --qos=normal
#SBATCH --partition=week-long-cpu
#SBATCH --job-name=HisatArrayCxt
#SBATCH --mail-user=$USER
#SBATCH --mail-type=all
#SBATCH --output=%x.%A-%a.log # gives slurm.ID.log

echo "[$0] $SLURM_JOB_NAME $@" # log the command line

module purge
source activate base
conda activate rnaPseudo

date # timestamp

filename=CulexTrimmed.txt # $1

prefix="../01_Fastp/DeDupTrimmed/DeDupTrimmed."
linenum=0
while read -r line
do
    if [ $SLURM_ARRAY_TASK_ID -eq $linenum ]
    then
      TWO=${line/_R1_/_R2_}
      OUT=${TWO#$prefix}
      #Remove Prefix
      echo ${OUT}
      hisat2 --phred33 --rna-strandness RF -p 100 -x HisatIndices/culexT_tran -1 ${line} -2 ${TWO} --no-discordant -S CxtConcordant/$OUT.sam
    fi
    linenum=$((linenum + 1))
done < $filename
