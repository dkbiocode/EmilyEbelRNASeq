#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --time=1-00:00:00
#SBATCH --job-name=build-splice-sites
#SBATCH --partition=day-long-cpu
#SBATCH --output=%x.%j.log # gives jobname.ID.log
source $HOME/templates/common.rc
conda_activate ebel

ORIG_GFF3=Culex-tarsalis_knwr_BASEFEATURES_CtarK1_filtered.gff3
FILT_GFF3=mrna_filtered.gff3
FILT_GTF=mrna_filtered.gtf

if [ ! -s $FILT_GFF3 ]
then
    cmd="grep -v '^#' Culex-tarsalis_knwr_BASEFEATURES_CtarK1.gff3 | awk '\$3 ~ /gene|mRNA|transcript|exon|CDS|five_prime_UTR|three_prime_UTR/' > mrna_filtered.gff3"
    echo $cmd
    eval $cmd
fi

if [ ! -s $FILT_GTF ]
then
    cmd="agat_convert_sp_gff2gtf.pl --gff $FILT_GFF3 -o $FILT_GTF"
    echo $cmd
    eval $cmd
fi

cmd="hisat2_extract_splice_sites.py --verbose $FILT_GTF > CtarK1.ss"
echo $cmd
time eval $cmd

cmd="hisat2_extract_exons.py --verbose $FILT_GTF > CtarK1.exon"
echo $cmd
time eval $cmd
