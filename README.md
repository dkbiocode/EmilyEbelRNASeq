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

Raw fastq files &rarr; [1. trim/filter](#1-trimmingfiltering) &rarr; [2. align](#2-alignment) &rarr; [3. count](#3-counts) &rarr; [4. differential expression](#4-differential-expression-analysis) & arr; GO term analysis 

## Methods 

Read processing, including quality control, alignment, and read counting are described in Hunter's sections. 

### Differential expression
Differential expression analysis was performed in DESeq2 (Love et al. 2014)[^1] version 1.48.2, R version 4.5, on htseq-count output described above. Full software versions for R sessions are listed in RMarkdown output available at [github.com/dkbiocode/EmilyEbelRNASeq](github.com/dkbiocode/EmilyEbelRNASeq). The raw counts were normalized and processed according to standard DESeq2 workflows before applying differential expression analysis for all combinations of experimental conditions: temperature 22°, 26° or 30° Celsius by mock or WNV infection, resulting in 15 comparisons. Genes were considered differential expressed in a given comparison when the adjust p-value (Benjamini-Hochberg) was less than 0.1. Interaction formulae were tested but not successful. 

### Functional term enrichment

#### Ortholog mapping of *Culex tarsalis* genes
Using the Ctark1 *Culex tarsalis* assembly (Main et al. 2020)[^2] coding gene predictions were aligned using diamondDB (**version xxxx**) in the eggnog/emapper pipeline (**version xxxx**) to assign orthologs to the closest annotated species in class Insecta. These mappings were combined with a previous mapping (**Fitzmeyer et al. 2023**)[^3], adding **1000** additional assignments to *Culex quinquefasciatus*, the phylogenetically closest, well annotated mosquito. 

This work utilized the Alpine High-Performance Computing resource at the University of Colorado Boulder. Alpine is jointly funded by the University of Colorado Boulder, the University of Colorado Anschutz, Colorado State University, and the National Science Foundation (award 2201538)[^4].

The *Culex quinquefasciatus* ortholog assignments were also linked to StringDB (Szklarczyk et al. 2023)[^5] 12.0 IDs for use in web tools, such as shinyGO. 100% of the StringDB 12.0 IDs were recognized by shinyGO. 

#### GO term enrichment analysis
GO term enrichment was performed using two methods. The first was executed solely in R with the topGO (Alexa et al. 2005)[^6] package 2.60.1 with the classic fisher and pruning algorithms. using GO terms assigned directly from the eggnog/emapper workflow described above. In any given comparison, all genes tested served as the background set, whereas all genes "significant" (adjusted p-value <. 1), were used as the foreground set. Details are available in the repository at **github.com.** These procedures yielded no enriched terms after multiple testing correction. 
To compare with previous analyses, the  *Culex quinquefasciatus* ortholog assignments were submitted to shinyGO ** version xxxx**, yielding only a single term for one comparison: **inorganic ion... for X vs Y.** Gene sets were defined as above and are available at **github.com.**

### AI usage disclosure
Claude Sonnet and GPT Sol 5.6 were used for coding support and pipeline development. 

## References
[^1]: Love, M.I., Huber, W., Anders, S. (2014) Moderated estimation of fold change and dispersion for RNA-seq data with DESeq2. Genome Biology, 15:550. 10.1186/s13059-014-0550-8
[^2]: Main BJ, Marcantonio M, Johnston JS, Rasgon JL, Brown CT, Barker CM. Whole-genome assembly of Culex tarsalis. G3 (Bethesda). 2021 Feb 9;11(2):jkaa063. doi: 10.1093/g3journal/jkaa063. PMID: 33585869; PMCID: PMC8022977.
[^3]: Fitzmeyer EA, Dutt TS, Pinaud S, Graham B, Gallichotte EN, et al. (2025) A single-cell atlas of the Culex tarsalis midgut during West Nile virus infection. PLOS Pathogens 21(1): e1012855. https://doi.org/10.1371/journal.ppat.1012855
[^4]: University of Colorado Boulder Research Computing. (2023). Alpine. University of Colorado Boulder. https://doi.org/10.25811/k3w6-pk81
[^5]: Szklarczyk D, Kirsch R, Koutrouli M, Nastou K, Mehryary F, Hachilif R, Gable AL, Fang T, Doncheva NT, Pyysalo S, Bork P, Jensen LJ, von Mering C. The STRING database in 2023: protein-protein association networks and functional enrichment analyses for any sequenced genome of interest. Nucleic Acids Res. 2023 Jan 6;51(D1):D638-D646. doi: 10.1093/nar/gkac1000. PMID: 36370105; PMCID: PMC9825434.
[^6]: Adrian Alexa, Jörg Rahnenführer, Thomas Lengauer, Improved scoring of functional groups from gene expression data by decorrelating GO graph structure, Bioinformatics, Volume 22, Issue 13, July 2006, Pages 1600–1607, https://doi.org/10.1093/bioinformatics/btl140



