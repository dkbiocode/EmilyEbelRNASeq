library(ggplot2)
library(dplyr)
library(tidyverse)
library(magrittr)
MAplot <- function(res, qthreshold=.1) {
  res_df <- as.data.frame(res)
  if (! "gene_id" %in% colnames(res_df)) {
    res_df %<>% rownames_to_column("gene_id")
  }
  res_df %<>% filter(is.finite(log(baseMean+1)) & is.finite(log2FoldChange))
  res_df %<>% mutate(sig = is.finite(padj) & (padj < qthreshold))
  
  res_df %>% ggplot(
      aes(
        x=log10(baseMean+1),
        y=log2FoldChange,
        color=sig,
      )) + geom_point() +
      scale_color_manual(values=c("grey", "blue")) +
      geom_hline(yintercept=0)
}