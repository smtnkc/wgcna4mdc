library(readr)
library(rstudioapi)
library(data.table) # to read big tables
library(STRINGdb) # to get STRING topology
library(WGCNA) # to get correlation matrix
library(org.Hs.eg.db) # to get entrez ids
library(svMisc) # to show progress

rm(list=ls())
setwd(dirname(getSourceEditorContext()$path))

source("prep.R")
source("helper.R")

df.gse <- as.data.frame(read.csv("DATA/GSE23561.csv", header = TRUE, 
                                 stringsAsFactors = FALSE, row.names = 1))
df.gpl <- as.data.frame(read.csv("DATA/GPL10775.csv", header = TRUE, 
                                 stringsAsFactors = FALSE))
df.gpl <- FormatDf(df.gpl)
df.gse <- cbind(SYMBOL = df.gpl$Symbol.v12, df.gse)
df.gse <- df.gse[!is.na(df.gse$SYMBOL), ]
df.gse <- GroupByCol(df.gse, col = 1)

df.map <- GetMapFor(df.gse)
df.gse.mapped <- NULL
df.gse.mapped <- cbind(SYMBOL = row.names(df.gse), df.gse)
df.gse.mapped <- merge(df.map, df.gse.mapped, by = "SYMBOL")
write.csv(df.gse.mapped, file = "DATA/EXPORT/GSE_MAPPED_17382.csv", row.names = FALSE)

source("plinks.R")

df.gse.sig <- df.gse.mapped[df.gse.mapped$STRING_id %in% v.proteins.sig, ]
write.csv(df.gse.sig, file = "DATA/EXPORT/GSE_SIG_14422.csv", row.names = FALSE)

source("cor.R")

# END OF MAIN #