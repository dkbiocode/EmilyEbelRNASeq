#!/bin/bash

#SBATCH --partition=amilan
#SBATCH --job-name=hisatTransscriptomeAedes
#SBATCH --output=%x.%j.out
#SBATCH --time=1:30:00
#SBATCH --qos=normal
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --mail-type=ALL
#SBATCH --mail-user=haogg@colostate.edu

module purge
source activate base
conda activate rnaPseudo


hisat2-build -p 24 culexGenome.fa AedesTransNew
