#!/bin/bash

#SBATCH --partition=day-long-cpu
#SBATCH --job-name=hisatRNALoopCxt
#SBATCH --output=%x.%j.out
#SBATCH --time=12:00:00
#SBATCH --qos=normal
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haogg@colostate.edu

module purge
source activate base
conda activate rnaPseudo

for FILE in trimmed/trimmed.Cx*R1*.fastq.gz
do
  TWO=${FILE/_R1_/_R2_}
  OUT=${TWO:16:(${#TWO}-25)} #Remove trimmed, and end. 23 is 8 (trimmed.) + 15 (R1_001$
  #echo ${TWO}
  echo $OUT
  hisat2 --phred33 --rna-strandness RF -p 16 -x culexT_tran -1 ${FILE} -2 ${TWO} -S CxtHisat/$OUT.sam
done
