#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --time=2:00:00
#SBATCH --qos=cpu-normal
#SBATCH --partition=acpu
#SBATCH --job-name=emapper
#SBATCH --mail-user=dcking@colostate.edu
#SBATCH --mail-type=END,FAIL,INVALID_DEPEND
#SBATCH --output=%x.%j.log # gives slurm.ID.log

module load miniforge # for conda
mamba activate eggnog

cmd="emapper.py -i ctar_genes/ctar_prot.gene.faa -o ctar \
  --itype proteins -m diamond \
  --data_dir eggnog-data \
  --tax_scope 50557 \
  --go_evidence all \
  --cpu ${SLURM_NTASKS=2}"
echo $cmd
time eval $cmd

ls ctar.emapper.annotations
