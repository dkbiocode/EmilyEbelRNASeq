#!/usr/bin/env bash
awk -F'\t' '$3=="mRNA" {
  match($9, /ID=[^;]+/);     id=substr($9, RSTART+3, RLENGTH-3);
  match($9, /Parent=[^;]+/); pa=substr($9, RSTART+7, RLENGTH-7);
  print id "\t" pa
}' $1 > mrna2gene.tsv
 
