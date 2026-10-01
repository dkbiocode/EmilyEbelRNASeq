
Ortholog mapping and annotation of *Culex tarsalis* genes for use in shinyGO 8.6.

## Resources and software

- shinyGO: https://bioinformatics.sdstate.edu/go/
- STRINGDB 12.0: https://stringdb-downloads.org/download/protein.aliases.v12.0/7176.protein.aliases.v12.0.txt.gz
- R version 4.5.1

## Methods

### *Culex tarsalis* annotations

R markdown and scripts: compare\_annot\_mappings.Rmd

Updated `Culex tarsalis` gene mappings were performed using emapper/eggnog (v2.1.15) on protein predictions based on the Main et al. 2020 `Culex tarsalis` genome assembly. Output from emapper was parsed in R (4.5.1) to produce CPIJ-prefix mappings for *Culex quinquefasciatis* when available. Those IDs were further processed in the same script in order to determine IDs in STRINGDB version 12, which was required by shinyGO. 100% of the STRINGDB IDs obtained in this way were recognized by shinyGO.


### shinyGO ###

For each contrast performed by DESeq2 (described above), foreground and background gene lists were exported and uploaded to the shinyGO webtool. Those lists are in `for_shinyGO and are named with the prefix of the contrasting experimental levels and the the suffix of "fore" or "back". The background lists for any combination of experimental groups is defined as the set of gene which were eligible to be included in the differential expression analysis, as determined by the presence of a numeric DESeq2 adjusted p-values `!is.na(padj)`. The foreground lists were the subset of these genes which pass the threshold described above.

Only one contrast yielded an enriched gene ontology term by shinyGO: Inorganic anion transmembrane transporter activity enriched by 5 genes (>15fold enrichment) in T22_WNV_vs_T26_mock. 
See for_shinyGO/T22_WNV_vs_T26_mock.pdf for shinyGO web output.


