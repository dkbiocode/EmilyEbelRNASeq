# hisat2 indices

Splice-aware indices were constructed using 

* ../HisatBaseFiles/Culex-tarsalis\_knwr\_BASEFEATURES\_CtarK1.gff3
* ../HisatBaseFiles/Culex-tarsalis\_knwr\_CONTIGS\_CtarK1.fa

The GTF file transcript annotation file, required to run hisat2-build with splice and exon 
annotations, was created by filtering out problematic features in the gff3 file listed above:

* ../HisatBaseFiles/BuildSpliceSites.sbatch
* ../HisatBaseFiles/mrna\_filtered.gff3
* ../HisatBaseFiles/mrna\_filtered.gtf

Finally, hisat2-build was run on mrna\_filtered.gtf to produce:

* ../HisatBaseFiles/CtarK1.exon
* ../HisatBaseFiles/CtarK1.ss
