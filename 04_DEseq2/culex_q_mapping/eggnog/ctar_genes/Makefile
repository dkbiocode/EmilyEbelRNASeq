GFF=Culex-tarsalis_knwr_BASEFEATURES_CtarK1.gff3
CONTIGS=Culex-tarsalis_knwr_CONTIGS_CtarK1.fa

default: mrna2gene.tsv ctar_prot.gene.faa

mrna2gene.tsv: 
	bash  mrna2gene.sh ${GFF}

ctar_prot.faa: 
	bash make_gene_fastas.sh

ctar_prot.gene.faa: mrna2gene.tsv ctar_prot.faa
	python match_protein_names_to_gff.py
