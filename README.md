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
Differential expression analysis was performed in DESeq2 (version x.xx, R version 4.5) on htseq-count output described above. Full software versions for R sessions are listed in Rmarkdown output available at github.com/dkbiocode/EmilyEbelRNAseq. The raw counts were normalized and processed according to standard DESeq2 workflows before applying differential expression analysis for all combinations of experimental conditions: temperature 22°, 26° or 30° Celsius by mock or WNV infection, resulting in 15 comparisons. Genes were considered differential expressed in a given comparison when the adjust p-value (Benjamini-Hochberg) was less than 0.1. Interaction formulae were tested but not successful. 



### Functional term enrichment

#### Ortholog mapping of *Culex tarsalis* genes
Using the Ctark1 *Culex tarsalis* assembly (Main et al. 2020) coding gene predictions were aligned using diamondDB (**version xxxx**) in the eggnog/emapper pipeline (**version xxxx**) to assign orthologs to the closest annotated species in class Insecta. These mappings were combined with a previous mapping (**Fizmeyer et al. 2023**), adding **1000** additional assignments to *Culex quinquefasciatus*, the phylogenetically closest, well annotated mosquito. 

This pipeline was executed on the Alpine cluster computer **(ref).** 

The *Culex quinquefasciatus* ortholog assignments were also linked to StringDB 12.0 IDs for use in web tools, such as shinyGO. 100% of the StringDB 12.0 IDs were recognized by shinyGO. 

#### GO term enrichment analysis
GO term enrichment was performed using two methods. The first was executed solely in R with the AmiGO package **(version xxxx)** with the classic fisher and pruning algorithms. using GO terms assigned directly from the eggnog/emapper workflow described above. In any given comparison, all genes tested served as the background set, whereas all genes "significant" (adjusted p-value <. 1), were used as the foreground set. Details are available in the repository at **github.com.** These procedures yielded no enriched terms after multiple testing correction. 
To compare with previous analyses, the  *Culex quinquefasciatus* ortholog assignments were submitted to shinyGO ** version xxxx**, yielding only a single term for one comparison: **inorganic ion... for X vs Y.** Gene sets were defined as above and are available at **github.com.**

### AI usage disclosure
Claude Sonnet and GPT Sol 5.6 were used for coding support and pipeline development. 

The 
