#!/bin/bash

#SBATCH --partition=day-long-cpu
#SBATCH --job-name=fastpLoop
#SBATCH --output=%x.%j.out
#SBATCH --time=6:00:00
#SBATCH --qos=normal
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haogg@colostate.edu

module purge
source activate base
conda activate rnaPseudo

for FILE in *R1_001.fastq.gz
do
  echo $FILE
  TWO=${FILE/_R1_/_R2_}
  TRIM1="../trimmed/trimmed."${FILE}
  TRIM2="../trimmed/trimmed."${TWO}
  #echo ${TWO}
  echo ${TRIM1}
  fastp -i ${FILE} -I ${TWO} -o ${TRIM1} -O ${TRIM2} -h FastqHTMLs/${TWO}.html -w 12
done
