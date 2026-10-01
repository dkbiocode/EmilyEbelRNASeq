# map_STRINGDB.R - create CPIJ_to_STRING.v12.0.tsv from 7176.protein.aliases.v12.0.txt
# shell: wget https://stringdb-downloads.org/download/protein.aliases.v12.0/7176.protein.aliases.v12.0.txt.gz
# NOTE: it is not the most recent version because shinyGO is on v12.0
# output file format:
# CPIJ_final      STRING_id
# CPIJ000117      7176.B0VYY7
# CPIJ000110      7176.B0VYY8
# CPIJ000118      7176.B0VYY9
# CPIJ000111      7176.B0VYZ0
# CPIJ000112      7176.B0VYZ1
# ----------
# Search 7176.B0VYY9 at string-db.org
# 7176 is the taxon ID for Culex quinquefascatis. Some applications require removing it.
# CPIJ is the Culex q. ID format
library(readr)
library(dplyr)
library(stringr)
stopifnot(basename(getwd()) == 'culex_q_mapping')

aliases <- read_tsv(
  "7176.protein.aliases.v12.0.txt",
  comment = "#",
  col_names = c("STRING_id", "alias", "source")
)

string_map <- aliases %>%
  filter(
    source == "KEGG_KEGGID_SHORT",
    str_detect(alias, "^CpipJ_CPIJ")
  ) %>%
  transmute(
    CPIJ_final = str_remove(alias, "^CpipJ_"),
    STRING_id
  ) %>%
  distinct()

write.table(string_map, "CPIJ_to_STRING.v12.0.tsv", sep="\t", quote=F, row.names=F)
