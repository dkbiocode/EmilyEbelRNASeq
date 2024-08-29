#!/bin/bash

#SBATCH --partition=day-long-cpu
#SBATCH --job-name=fastpDeDupLoop
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
  TRIM1="../DEDtrim/DEDtrim."${FILE}
  TRIM2="../DEDtrim/DEDtrim."${TWO}
  #echo ${TWO}
  echo ${TRIM1}
  fastp -i ${FILE} -I ${TWO} -o ${TRIM1} -O ${TRIM2} -h ../DeDupFastqHTMLs/${TWO}.html -w 12 --dedup
done
