#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=04:00:00
#SBATCH --qos=normal
#SBATCH --partition=day-long-cpu
#SBATCH --job-name=hscountArrayAedes
#SBATCH --mail-user=$USER
#SBATCH --mail-type=all
#SBATCH --output=%x.%A-%a.log # gives slurm.ID.log
#SBATCH --array=0-31

echo "[$0] $SLURM_JOB_NAME $@" # log the command line

module purge
source activate base
conda activate rnaPseudo

date # timestamp

filename=AedesSams.txt # $1

linenum=0
while read -r line
do
    #echo $SLURM_ARRAY_TASK_ID
    #echo $linenum
    if [ $SLURM_ARRAY_TASK_ID -eq $linenum ]
    then
      pref=${line::-4}
      #pref=${pref:9}
      echo ${pref}
      htseq-count --stranded=no $line AedesGenesNew.gtf > hsCountsAedes/${pref}.HSCounts.txt
    fi
    linenum=$((linenum + 1))
done < $filename
