#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --time=02:00:00
#SBATCH --job-name=screen-array
#SBATCH --partition=day-long-cpu
#SBATCH --output=slurm/logs/%x.%A_%a.log # like: jobname-job.ID_1.log
# Use: sbatch --array=0 screen.sbatch ../DeDupTrimmed/*.fastq.gz
# Use: sbatch --array=1-35 screen.sbatch ../DeDupTrimmed/*.fastq.gz
datetime=$(date +"%Y-%m-%d_%H:%M:%S")
echo "[$datetime] $SLURM_JOB_NAME $@" # log the command line
echo "SLURM_JOBID=$SLURM_JOBID"
echo "SLURM_ARRAY_TASK_ID=${SLURM_ARRAY_TASK_ID:=0}"

mkdir -p $HOME/tmp
export TMP=$HOME/tmp
export TMPDIR=$TMP

# load a conda environment 
cmd="source /nfs/home/dking/miniconda3/bin/activate ebel"
echo $cmd
eval $cmd

# command line
cmd_args=($@)
array_arg=${cmd_args[$SLURM_ARRAY_TASK_ID]}


##### run script with the resolved array ID to argument
echo "array_arg=$array_arg"
cmd="fastq_screen --conf fastq_screen.conf --tag --subset 0 $array_arg"
echo $cmd
time eval $cmd

