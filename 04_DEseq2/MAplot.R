library(ggplot2)
library(dplyr)
library(tidyverse)
library(magrittr)
MAplot <- function(res, qthreshold=.1) {
  res_df <- as.data.frame(res)
  if (! "gene_id" %in% colnames(res_df)) {
    res_df %<>% rownames_to_column("gene_id")
  }

  # filter for any kind of NAs that make the value undefined in the plotting range, or the color aes.
  res_df %<>% filter(is.finite(log(baseMean+1)) & is.finite(log2FoldChange))
  res_df %<>% mutate(sig = is.finite(padj) & (padj < qthreshold))
  res_df %<>% arrange(sig) # put the significant points ontop

  maplot <- res_df %>% ggplot(
      aes(
        x=log10(baseMean+1),
        y=log2FoldChange,
        color=sig,
        size=sig
      )) + geom_point() +
      scale_color_manual(values=c("grey", "blue")) +
      geom_hline(yintercept=0) +
    labs(color=sprintf("q-value < %.2f", qthreshold)) +
    scale_size_manual(values=c(.5,1), guide="none") 

  
  maplot
  return(maplot)
  
}