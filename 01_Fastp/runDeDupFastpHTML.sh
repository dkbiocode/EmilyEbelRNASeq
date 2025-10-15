#!/bin/bash
#SBATCH --partition=day-long-cpu
#SBATCH --job-name=fastpDeDupLoop
#SBATCH --output=%x.%A_%a.log 
#SBATCH --time=2:00:00
#SBATCH --qos=normal
#SBATCH --nodes=1
#SBATCH --ntasks=16
# ls -1 RawFastq/*R1_001.fastq.gz | wc -l => 18
# use 
#   sbatch --array=0-17 runDeDupFastpHTML.sh 
source $HOME/templates/common.rc
conda_activate ebel

echo "JOB ARRAY TASK: ${SLURM_ARRAY_TASK_ID:=1}, SLURM_NTASKS=${SLURM_NTASKS:=0}"

cmd_args=( $(ls RawFastq/*R1_001.fastq.gz) )
FILE=${cmd_args[$SLURM_ARRAY_TASK_ID]}
TWO=${FILE/_R1_/_R2_}
OUT=${TWO/#RawFastq\/}
TRIM1=${FILE/RawFastq\//DeDupTrimmed\/DeDupTrimmed.}
TRIM2=${TWO/RawFastq\//DeDupTrimmed\/DeDupTrimmed.}  
echo TRIM1=${TRIM1}
echo TRIM2=${TRIM2}

OUT=$(basename $OUT .fastq.gz)
echo OUT=${OUT}
cmd="fastp -i ${FILE} -I ${TWO} -o ${TRIM1} -O ${TRIM2} -j DeDupFastqJSONs/${OUT}.json -h DeDupFastqHTMLs/${OUT}.html -w $SLURM_NTASKS --dedup"
echo "$cmd"
time eval "$cmd"
