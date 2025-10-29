#!/usr/bin/env Rscript
parts = expand.grid(temp=c("22","26","30"),inf=c("WNV","mock"),rep=c("A","B","C"))
prefixes = sprintf("%s_%s_%s", parts$temp, parts$inf, parts$rep)
filenames = sprintf("%s.HSCounts.txt", prefixes)

# make subscriptable by the corresponding filename
names(prefixes) <- filenames 

directory = "hsCountsConcordantCxt"

df = data.frame()

for (fname in dir(directory, "*.txt")) {
    
    x = read.table(file.path(directory,fname), row.names=1, col.names=c("geneName", prefixes[fname]))
    if (length(df)>0) {
        stopifnot(all(rownames(df) == rownames(x)))
        df = cbind(df, x)
    }
    else {
        df = x
    }
}

write.table(df, "allCxtCounts.tsv", row.names=T, quote=F, sep="\t")
