#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --time=20:00:00
#SBATCH --qos=normal
#SBATCH --partition=day-long-cpu
#SBATCH --job-name=BamConvert
#SBATCH --mail-user=$USER
#SBATCH --mail-type=all
#SBATCH --output=%x.%j.log # gives slurm.ID.log
source $HOME/templates/common.rc
echo "Using SLURM_NTASKS=${SLURM_NTASKS:=1} SLURM_NTASKS"
ADDED_NTASKS=$((SLURM_NTASKS - 1))
#conda_activate ebel

for SAM in CxtConcordant/*.sam
do
  BAM=${SAM/.fastq.gz.sam/.bam}
  echo "$SAM => ${BAM}"
  cmd="samtools view -bS -@${ADDED_NTASKS} $SAM > $BAM"
  echo $cmd
  time eval "$cmd"

  rm_cmd="samtools quickcheck "$BAM" && rm -v $SAM"
  echo $rm_cmd
  eval "$rm_cmd"

  echo
done
