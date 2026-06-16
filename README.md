# RNA-seq analysis of temperature dependent response to West Nile Virus in *Culex tarsalis* mosquitos 

Title: **Temperature alters *Culex tarsalis* West Nile virus vector competence, tissue bottlenecks, and transcriptional responses**

Preprint: link

Publication: link

---

* Authors: Emily N Gallichotte, Bri Marsico, Emily A Fitzmeyer, Hunter A Ogg, David C King, Kate X. Kimball, Nora Ebel, Corey L Campbell, Gregory D Ebel
* Sample prep: Bri Marsico
* Analysis: Hunter Ogg and David King 

## Synopsis 

Three replicates each of paired-end RNA-seq at three temperatures: 22, 26, and 30. Infected by mock infection or WNV. 

## Analysis 

Raw fastq files &rarr; [1. trim/filter](01_Fastp) &rarr; [2. align](02_Hisat2) &rarr; [3. count](03_htseqCount/) &rarr; [4. differential expression](04_DEseq2/)
