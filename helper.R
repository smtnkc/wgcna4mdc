GetMapFor <- function(df.gse) {
  strdb <- STRINGdb$new(species = 9606, version = "10")
  cat("Number of proteins:", nrow(strdb$get_proteins()), "\n")
  df.map <- as.data.frame(select(org.Hs.eg.db, keys = row.names(df.gse), columns = c("ENTREZID", "SYMBOL"), keytype = "SYMBOL"))
  df.map <- strdb$map(df.map, c("ENTREZID", "SYMBOL"), takeFirst = TRUE, removeUnmappedRows = FALSE, quiet = FALSE)
  df.map <- df.map[!duplicated(df.map$SYMBOL), ]
  df.map <- df.map[, -1]
  df.map <- df.map[!is.na(df.map$STRING_id), ]
  df.map <- df.map[!duplicated(df.map$STRING_id), ]
  return(df.map)
}

AppendCor <- function(df.plinks, df.exp, range, tool) {
  df.corr <- cor(x = t(df.exp[, range]), y = NULL, method = tool)
  cat("Correlation matrix has been generated!\n")
  cat("Dimensions =", dim(df.corr)[1] , "x", dim(df.corr)[2], "\n")
  cat("Appending correlation scores...\n")

  df.result <- df.plinks
  df.result[ , "Spearman_Score"] <- NA
  
  for(i in 1:nrow(df.plinks)) {
    df.result[i, "Spearman_Score"] <- df.corr[df.plinks[i, "protein1"], 
                                              df.plinks[i, "protein2"]]
  }
  cat("DONE!\n")  
  return(df.result)
}

RunCorTest <- function(row, cols) {
  x <- as.numeric(as.vector(df.exp.corr[row, cols]))
  y <- as.numeric(as.vector(df.exp.corr[row+1, cols]))
  cat("row", row, "->", x, "\n")
  cat("row", row+1, "->", y, "\n")
  for(tool in c("pearson", "spearman", "kendall")) {
    if(tool == "spearman")
      cat(tool, "-> ")
    else cat(tool, " -> ")
    cat(round(cor.test(x,y,method=tool, exact = FALSE)$estimate, 3),
        round(cor.test(x,y,method=tool, exact = FALSE)$p.value, 3), "\n")
  }
}

# RunCorTest(8001, c(1:9))



