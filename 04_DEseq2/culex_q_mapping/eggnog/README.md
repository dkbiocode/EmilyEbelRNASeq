# Eggnog/emapper

Update annotations from *Culex tarsalis* assembly (Main et al.) in order to map IDs (e.g. geneXXXX) to *Culex quinquefasciatis* (and beyond), to get functional annotations.

## Genome (ctar\_genes)

Detailed instructions are in ctar\_genes/

- Download *Culex tarsalis* protein/gene annotations from Main et al.
- Use the Makefile to run scripts which extract sequences from the contigs and produce `ctar_prot.gene.faa`

## Eggnog and emapper



### Alpine cluster scripts

- download-eggnog.sbatch - download the annotations needed for to map `ctar_prot.gene.faa` to ortholog groups.
- emapper.sbatch - performs mapping

Alpine cluster is maintained by CU Research Computing and run through a partnership between Colorado State University and CU Boulder.

This work utilized the Alpine High-Performance Computing resource at the University of Colorado Boulder. Alpine is jointly funded by the University of Colorado Boulder, the University of Colorado Anschutz, Colorado State University, and the National Science Foundation (award 2201538).

- DOI: https://doi.org/10.25811/k3w6-pk81
- Citation: University of Colorado Boulder Research Computing. (2023). Alpine. University of Colorado Boulder. https://doi.org/10.25811/k3w6-pk81



---

eggnog-emapper version: https://conda.anaconda.org/bioconda/noarch/eggnog-mapper-2.1.15-pyhdfd78af\_0.conda
