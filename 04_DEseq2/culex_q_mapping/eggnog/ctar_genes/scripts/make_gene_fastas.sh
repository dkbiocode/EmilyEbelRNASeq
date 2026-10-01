#!/usr/bin/env bash
set -eu
URL='https://osf.io/mdwqx/overview'
GFF=Culex-tarsalis_knwr_BASEFEATURES_CtarK1.gff3
CONTIGS=Culex-tarsalis_knwr_CONTIGS_CtarK1.fa
FILES="$GFF $CONTIGS"
ANNOTATIONS=annotations # directory for GFF and CONTIGS

prev_dir=$PWD
cd $ANNOTATIONS
echo "Checking for files..."

for file in $FILES
do
    if [ -e $file.gz ]
    then
        gunzip $file.gz
    elif [ -e $file ]
    then
        echo "Found $file"
    else
        echo "ERROR: neither $file (or gzipped version) found, go to $URL to download."
        echo "Make sure you have both of $FILES"
        exit 1
    fi
done
cd $prev_dir

echo "Checking for gffread..."

if hash gffread
then
    echo "gffread found."
else
    echo "gffread NOT FOUND. Install via bioconda"
    exit 1
fi

echo "Extracting gene models..."

cmd="gffread $ANNOTATIONS/$GFF -g $ANNOTATIONS/$CONTIGS -y ctar_prot.faa -x ctar_cds.fa -w ctar_transcripts.fa 2> gffread.warnings.txt"
echo $cmd
time eval "$cmd"

wc -l ctar_prot.faa ctar_cds.fa ctar_transcripts.fa gffread.warnings.txt
