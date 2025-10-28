#!/usr/bin/env bash
# take out any extraneous extensions from the illumina naming convention

for fname in *.bam;
do
    shortname=$(echo $fname | awk -F_ '{printf("%s_%s_%s.bam", $1, $2, $3) }')
    cmd="mv $fname $shortname"
    echo $cmd
done
