#!/bin/bash

#SBATCH --partition=acompile
#SBATCH --job-name=htseqCount
#SBATCH --output=%x.%j.out
#SBATCH --time=24:00:00
#SBATCH --qos=compile
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haogg@colostate.edu

module purge
module load anaconda
conda activate rnaPseudo

for FILE in hisatRNA/*.sam
do
  #echo ${TWO}
  pref=${FILE::-4}
  pref=${pref:9}
  echo ${pref}
  htseq-count --stranded=reverse $FILE genes.gtf > hsCountsRev/${pref}HSCounts.txt
done
