library(ggplot2)
library(dplyr)
library(tidyverse)
library(magrittr)
MAplot <- function(res) {
  res_df <- as.data.frame(res) %>%
    rownames_to_column("gene_id")

}