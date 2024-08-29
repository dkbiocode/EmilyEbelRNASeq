#!/bin/bash

#SBATCH --partition=acompile
#SBATCH --job-name=hisatDNAPairedOnly
#SBATCH --output=%x.%j.out
#SBATCH --time=4:00:00
#SBATCH --qos=compile
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haogg@colostate.edu

module purge
module load anaconda
conda activate rnaPseudo


for FILE in trimmed/trimmed.*R1*.fastq.gz
do
 TWO=${FILE/_R1_/_R2_}
 OUT=${TWO:16:(${#TWO}-40)}
 echo ${OUT}
 hisat2 --phred33 -p 16 -x genome -1 ${FILE} -2 ${TWO} -S hisatPairStrict/${OUT}.sam --no-mixed --no-discordant
done

