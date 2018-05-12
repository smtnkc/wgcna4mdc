GetMapFor <- function(df.gse) {

  strdb <- STRINGdb$new(species = 9606, version = "10")

  cat("Number of proteins:", nrow(strdb$get_proteins()), "\n")
  df.map <- as.data.frame(select(org.Hs.eg.db,
                                 keys = row.names(df.gse),
                                 columns = c("ENTREZID", "SYMBOL"),
                                 keytype = "SYMBOL"))

  df.map <- strdb$map(df.map,
                      c("ENTREZID", "SYMBOL"),
                      takeFirst = TRUE,
                      removeUnmappedRows = FALSE,
                      quiet = FALSE)

  df.map <- df.map[!duplicated(df.map$SYMBOL), ]
  df.map <- df.map[, -1]
  df.map <- df.map[!is.na(df.map$STRING_id), ]
  df.map <- df.map[!duplicated(df.map$STRING_id), ]

  return(df.map)
}

AppendCor <- function(df.plinks, df.gse, range, tool) {

  col = paste(tool, "score", sep = "_")
  cat("Getting", col, "values...\n")

  df.adj <- WGCNA::cor(x = t(df.gse[, range]), y = NULL, method = tool)

  cat("Adjacency matrix has been generated!\n")
  cat("Dimensions =", dim(df.adj)[1] , "x", dim(df.adj)[2], "\n")
  cat("Appending", col, "values to edgelist...\n")

  df.result <- df.plinks
  df.result[, col] <- NA

  for(i in 1:nrow(df.plinks)) {
    df.result[i, col] <- 
      df.adj[df.plinks[i, "protein1"], df.plinks[i, "protein2"]]
  }

  cat("DONE!\n")

  return(df.result)
}

RunCorTest <- function(df, row, cols) {

  x <- as.numeric(as.vector(df[row, cols]))
  y <- as.numeric(as.vector(df[row+1, cols]))

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

RunCorTest(df.gse.sig, 8901, c(3:12))

# END OF HELPER