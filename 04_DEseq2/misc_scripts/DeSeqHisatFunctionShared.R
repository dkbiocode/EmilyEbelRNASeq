#https://lashlock.github.io/compbio/R_presentation.html
#https://www.bioconductor.org/packages/release/bioc/vignettes/DESeq2/inst/doc/DESeq2.html
library(DESeq2)
library(ggplot2)
library(pheatmap)
library("vsn")
library(EnhancedVolcano)

#Should be set to the directory to which you want files to be save
#Use a '/' instead of '\\' if using a Mac/Linux system.
setwd("C:\\Users\\hunte\\Desktop\\mosquitoLifeStageRNA")

#Should be set to the directory containing 
#Use a '/' instead of '\\' if using a Mac/Linux system.
directory <- "C:\\Users\\hunte\\Desktop\\mosquitoLifeStageRNA\\allCounts"


#THIS FUNCTION ONLY NEEDS TO BE RUN ONCE PER SESSION SO IT CAN BE PLACED IN MEMORY

getDeseqResults = function(sampleFile,plots=TRUE,lifestage=FALSE,save=FALSE,byLifestage=FALSE,byCombined=FALSE,summary=TRUE,
                           byPCR=FALSE,byAnyPositive=FALSE,vsAdult=FALSE,vsLarvae=FALSE,saveName="Exampledds.RDS"){
  
  
  sampleTable=read.csv(sampleFile)
  #Setting variables as factors so they can be used properly be DEseq2
  sampleTable$Lifestage=as.factor(sampleTable$Lifestage)
  sampleTable$PCR=as.factor(sampleTable$PCR)
  sampleTable$PlaqueAssay=as.factor(sampleTable$PlaqueAssay)
  sampleTable$Combined=as.factor(sampleTable$Combined)
  sampleTable$AnyPositive=as.factor(sampleTable$Combined)
  
  #If a lifestage is provided, subset data to only include that lifestage
  if(lifestage!=FALSE){
    sampleTable=sampleTable[sampleTable$Lifestage==lifestage,]
  }
  
  #Choose condition to use for the groups which will be compared
  if(byLifestage){
    if(vsAdult){
      sampleTable=sampleTable[sampleTable$Lifestage!="L4",]
      ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable,
                                             directory = directory,
                                             design=~ Lifestage)
    }
    else if(vsLarvae){
      sampleTable=sampleTable[sampleTable$Lifestage!="Adult",]
      ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable,
                                             directory = directory,
                                             design=~ Lifestage)
    }
    else{
      stop("Must set either 'vsAdult' or 'vsLarve' to TRUE if using 'byLifestage=TRUE'")
    }
  }
  else if(byPCR){
    ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable,
                                           directory = directory,
                                           design=~ PCR)
  }
  else if(byAnyPositive){
    #Counts samples with either PCR and Plaque positivity as positive
    ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable,
                                           directory = directory,
                                           design=~ AnyPos)
  }
  else{
    #Plaque assay is the default comparison condition
    ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable,
                                           directory = directory,
                                           design=~ PlaqueAssay)
  }
  
  if(plots){
    rld <- rlog(ddsHTSeq, blind=TRUE)
    
    if(lifestage==FALSE){
      print(plotPCA(rld, intgroup="Lifestage"))
    }
    
    print(plotPCA(rld, intgroup="Combined"))
    
    rld_mat <- assay(rld)

    rld_cor <- cor(rld_mat) 
    
    pheatmap(rld_cor)
  }
  
  htdds <- DESeq(ddsHTSeq)
  
  #saveRDS(htdds, file="lifestageHTDDS.rds")
  #htres <- results(htdds)
  if(byLifestage){
    if(vsAdult){
      htres <- results(htdds,contrast=c("Lifestage","Pupae","Adult"))
    }
    else{
      htres <- results(htdds,contrast=c("Lifestage","L4","Pupae")) 
    }
  }
  else if(byPCR){
    htres <- results(htdds,contrast=c("PCR","positive","negative"))
  }
  else if(byAnyPositive){
    htres <- results(htdds,contrast=c("AnyPos","Yes","No"))
  }
  else{
    htres <- results(htdds,contrast=c("PlaqueAssay","positive","negative"))
  }
  if(plots){
    print(EnhancedVolcano(htres,
                          lab = rownames(htres),
                          x = 'log2FoldChange',
                          y = 'pvalue')) 
  }
  htres <- htres[order(htres$pvalue),]
  if(save){
    #Change the "saveName" parameter this to save to a different file. It will save to the
    #current working directory defined above and will overrite files with the same name
    saveRDS(htdds,file=paste(saveName,".RDS",sep=""))
    write.csv(htres,file=paste(saveName,".csv",sep=""))
  }
  if(summary){
    #If summary is true, return just the dataframe summary
    return(htres)
  }
  #If summary is not true, return the raw object
  return(htdds)
} 

test=getDeseqResults("LifeStageSamplesTest3.csv",lifestage="Adult",save=TRUE,summary=TRUE)
head(test,n=20)
write.csv(test,"CulexAdultPlaqueTable.csv")


test=getDeseqResults("LifeStageSamplesAeAll.csv",save=TRUE,summary=TRUE)
test=getDeseqResults("LifeStageSamplesAeAll.csv",lifestage="Pupae",save=TRUE,summary=TRUE)
test=getDeseqResults("LifeStageSamplesAeAll.csv",lifestage="Adult",save=TRUE,summary=TRUE)

res_tab=getDeseqResults("LifeStageSamplesAeAll.csv",lifestage="Adult",save=TRUE,summary=TRUE,saveName = "AedesAdultPlaque")
head(res_tab,n=20)
write.csv(res_tab,"AedesAdultPlaqueTable.csv")

res_tab=getDeseqResults("LifeStageSamplesAeAll.csv",lifestage="Pupae",save=TRUE,summary=TRUE,saveName = "AedesPupaePlaque")
head(res_tab,n=20)
write.csv(res_tab,"AedesPupaePlaqueTable.csv")

res_tab=getDeseqResults("LifeStageSamplesAeAll.csv",lifestage="Pupae",byPCR=TRUE,save=TRUE,summary=TRUE,saveName = "AedesPupaePCR")
head(res_tab,n=20)
write.csv(res_tab,"AedesPupaePCRTable.csv")

res_tab=getDeseqResults("LifeStageSamplesAeAll.csv",lifestage="Pupae",byAnyPositive=TRUE,save=TRUE,summary=TRUE,saveName = "AedesPupaePos")
head(res_tab,n=20)
write.csv(res_tab,"AedesPupaePosTable.csv")

res_tab=getDeseqResults("LifeStageSamplesAeAll.csv",lifestage="L4",save=TRUE,summary=TRUE,saveName = "AedesL4Plaque")
head(res_tab,n=20)
write.csv(res_tab,"AedesL4PlaqueTable.csv")

res_tab=getDeseqResults("LifeStageSamplesTest.csv",lifestage="Adult",save=TRUE,summary=TRUE,saveName = "CulexAdultPlaque")
head(res_tab,n=20)
#write.csv(res_tab,"CulexAdultPlaqueTable.csv")

res_tab=getDeseqResults("LifeStageSamplesAeAll.csv",lifestage="L4",save=TRUE,summary=TRUE,saveName = "AedesL4Plaque")
head(res_tab,n=20)
write.csv(res_tab,"AedesL4PlaqueTable.csv")

test=getDeseqResults("LifeStageSamplesTest3.csv",lifestage="Adult",save=TRUE,summary=TRUE,saveName = "CulexAdultPlaque")
head(test,n=10)

test=getDeseqResults("LifeStageSamplesTest3.csv",lifestage="Adult",byPCR=TRUE,save=TRUE,summary=TRUE,saveName = "CulexAdultPlaque")
head(test,n=10)

res_tab=getDeseqResults("LifeStageSamplesTest3.csv",lifestage="Adult",byAnyPositive=TRUE,save=TRUE,summary=TRUE,saveName = "CulexAdultPos")
head(res_tab,n=10)

res_tab=getDeseqResults("LifeStageSamplesTest3.csv",lifestage="Pupae",byAnyPositive=TRUE,save=TRUE,summary=TRUE,saveName = "CulexPupaePos")
head(res_tab,n=10)

res_tab=getDeseqResults("LifeStageSamplesTest3.csv",lifestage="Pupae",byAnyPositive=TRUE,save=TRUE,summary=TRUE,saveName = "CulexPupaePlaque")
head(res_tab,n=10)

res_tab=getDeseqResults("LifeStageSamplesTest3.csv",lifestage="L4",byAnyPositive=TRUE,save=TRUE,summary=TRUE,saveName = "CulexL4Pos")
head(res_tab,n=20)

res_tab=getDeseqResults("LifeStageSamplesTest3.csv",lifestage="L4",byAnyPositive=TRUE,save=TRUE,summary=TRUE,saveName = "CulexL4Pos")
head(res_tab,n=20)

res_tab=getDeseqResults("LifeStageSamplesTest3.csv",lifestage="Pupae",save=TRUE,summary=TRUE,saveName = "CulexL4Pos")
head(res_tab,n=20)

res_tab=getDeseqResults("LifeStageSamplesAeAll.csv",byLifestage = TRUE,vsLarvae=TRUE,save=TRUE,summary=TRUE,saveName = "AedesPupaevsLarvae")
head(res_tab,n=10)

res_tab=getDeseqResults("LifeStageSamplesAeAll.csv",byLifestage = TRUE,vsAdult=TRUE,save=TRUE,summary=TRUE,saveName = "AedesPupaevsAdult")
head(res_tab,n=10)


#Example of Plotting Specific Genes Across Samples using a saved DEseq2 object

htdds=readRDS(file="AedesPupaevsAdult.RDS")

head(htdds)

htdds["MT-ND1",]$ID

plotCounts(htdds, gene="GPROP2", intgroup="PlaqueAssay")
plotCounts(htdds, gene="gene4787", intgroup="PlaqueAssay")


plotCounts(htdds, gene="AAEL006966", intgroup="PlaqueAssay")
plotCounts(htdds, gene="AAEL005646", intgroup="PlaqueAssay")
plotCounts(htdds, gene="AAEL012311", intgroup="PlaqueAssay")