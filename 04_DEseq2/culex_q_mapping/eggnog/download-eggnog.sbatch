#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=2:00:00
#SBATCH --qos=cpu-normal
#SBATCH --partition=acpu
#SBATCH --job-name=eggnog-download
#SBATCH --mail-user=dcking@colostate.edu
#SBATCH --mail-type=END,FAIL,INVALID_DEPEND
#SBATCH --output=%x.%j.log # gives slurm.ID.log

if false # eggnog's URLs are defunct
then
    module load miniforge # for conda
    mamba activate eggnog
    cmd="download_eggnog_data.py --data_dir eggnog-data -y"
    echo $cmd
    time eval $cmd
fi

# manual
cd eggnog-data
BASE=http://eggnog5.embl.de/download/emapperdb-5.0.2

wget $BASE/eggnog.db.gz          && gunzip eggnog.db.gz
wget $BASE/eggnog.taxa.tar.gz    && tar -zxf eggnog.taxa.tar.gz
wget $BASE/eggnog_proteins.dmnd.gz && gunzip eggnog_proteins.dmnd.gz
