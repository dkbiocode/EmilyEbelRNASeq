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
source $HOME/templates/common.rc
echo "Using SLURM_NTASKS=${SLURM_NTASKS:=0} SLURM_NTASKS"
echo "Running SLURM_ARRAY_TASK_ID=${SLURM_ARRAY_TASK_ID:=0}"
conda_activate ebel

filename=FastqInputFileList.txt

prefix="../01_Fastp/DeDupTrimmed/DeDupTrimmed."
index_prefix="HisatIndices/Cxt"
linenum=0
while read -r line
do
    if [ $SLURM_ARRAY_TASK_ID -eq $linenum ]
    then
      TWO=${line/_R1_/_R2_}
      OUT=${TWO#$prefix}
      #Remove Prefix
      echo "$linenum: OUT=${OUT}"
      cmd="hisat2 --rna-strandness RF -p $SLURM_NTASKS -x $index_prefix -1 ${line} -2 ${TWO} --no-discordant -S CxtConcordant/$OUT.sam"
      echo $cmd
      # time eval $cmd
    fi
    linenum=$((linenum + 1))
done < $filename
