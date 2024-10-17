setwd("C:\\Users\\hunte\\Desktop\\mosquitoLifeStageRNA\\Annotations")

replaceGeneNameCxt = function(featLoc, namesLoc){
  #Remove .gz for certain parts
  #cutFeatLoc = substring(featLoc,1,nchar(featLoc)-3)
  
  #This is thte column of the names file that contains the desired annotations
  colNum=4
  #
  feats = read.table(featLoc)

  annotations = read.csv(file = namesLoc, 
                         header=TRUE,skipNul = TRUE)
  
  ans = rep(TRUE, length(annotations[,colNum]))
  for (i in seq(annotations[,colNum])){
    if (nchar(annotations[i,colNum]) == 0){
      ans[i] = FALSE
    } 
  }
  #print(ans)
  filtered_an = annotations[ans,]
  filtered_genes = annotations[ans,1]#1]
  #print(filtered_genes)
  nrow(feats)
  for (i in seq(nrow(feats))){
    name = feats[i,1] #1 or 2 works
    if (name %in% filtered_genes){
      #print("in")
      temp = filtered_an[filtered_an[1] == name,colNum]
      #print(temp)
      if (length(temp)>1){
        temp = temp[1]
      }
      temp = gsub("\\s", "", temp)
      feats[i,1] = temp
      #feats[i,2] = temp
    }
  }
  
  write.table(feats, file=featLoc, quote=FALSE, sep='\t', col.names = FALSE, row.names = FALSE)
  #gzip(cutFeatLoc,overwrite=TRUE)
}

replaceGeneNameAedes = function(featLoc, namesLoc){
  #Remove .gz for certain parts
  #cutFeatLoc = substring(featLoc,1,nchar(featLoc)-3)
  
  #This is the column of the names file that contains the desired annotations
  colNum=6
  
  #This is the column of the names file that contains the original names to search against
  origCol=2
  
  feats = read.table(featLoc)
  #Does table work?
  
  annotations = read.csv(file = namesLoc, 
                         header=TRUE,skipNul = TRUE)
  
  ans = rep(TRUE, length(annotations[,colNum]))
  for (i in seq(annotations[,colNum])){
    if (nchar(annotations[i,colNum]) == 0){
      ans[i] = FALSE
    }
    if (annotations[i,colNum] == "N/A"){
      ans[i] = FALSE
    }
  }
  print(ans)
  filtered_an = annotations[ans,]
  filtered_genes = annotations[ans,origCol]#1]
  print(filtered_genes)
  nrow(feats)
  for (i in seq(nrow(feats))){
    name = feats[i,1] #1 or 2 works
    if (name %in% filtered_genes){
      #print("in")
      temp = filtered_an[filtered_an[origCol] == name,colNum]
      #print(temp)
      if (length(temp)>1){
        temp = temp[1]
      }
      temp = gsub("\\s", "", temp)
      feats[i,1] = temp
      #feats[i,2] = temp
    }
  }
  
  write.table(feats, file=featLoc, quote=FALSE, sep='\t', col.names = FALSE, row.names = FALSE)
  #gzip(cutFeatLoc,overwrite=TRUE)
}

#Example Usage for Single File
#featLoc is the HTseq output file which contains counts of the features
#namesLoc is the Annotation file which contains the translation from the old
#features to new annotation names
replaceGeneNameCxt("CulexCounts.txt","Cxt_annot_corrections202404424.csv")

replaceGeneNameAedes("HSCounts.txt","Aedes_Ae_gene_annotations_PE20240508.csv")


#CHANGE THIS BASED ON WHERE YOUR
setwd("C:\\Users\\hunte\\Desktop\\mosquitoLifeStageRNA\\allCounts")

#Example usage for folder full of files matching a given pattern
#Files that begin with a capital C
CulexFiles = list.files(pattern = "^C")

#Files that begin with a capital A
AedesFiles = list.files(pattern = "^A")

for(file in AedesFiles){
  replaceGeneNameAedes(file,"..\\Annotations\\Aedes_Ae_gene_annotations_PE20240508.csv")
}

for(file in CulexFiles){
  replaceGeneNameCxt(file,"..\\Annotations\\Cxt_annot_corrections202404424.csv")
}


