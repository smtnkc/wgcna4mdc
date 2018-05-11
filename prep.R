FormatDf <- function(df) {
  df[df == "-"] <- NA
  df[df == "."] <- NA
  df[df == "Null"] <- NA
  df[df == "--Null"] <- NA
  df[df == "EMPTY"] <- NA
  df[df == ""] <- NA
  df[df == "--empty"] <- NA
  df[df == "--unknown"] <- NA
  df[df == "0"] <- NA
  #df[df == "Dye Marker"] <- NA
  #df <- df[, 1:8]
  return (df)
}

GroupByCol <- function(df, col) {
  df <- aggregate(df[, -col], list(toupper(df[, col])), mean)
  v.symbols <- unlist(df[, col])
  df <- round(df[, -col], 2)
  row.names(df) <- v.symbols
  return(df)
}

GroupByStates <- function(df) {
  df.group <- NULL
  df.group <- data.frame(Control = rowMeans(df.exp[ ,1:9]))             # 9 Control
  df.group <- cbind(df.group, data.frame(RA = rowMeans(df[ ,10:15])))   # 6 RA
  df.group <- cbind(df.group, data.frame(MetS = rowMeans(df[ ,16:21]))) # 6 MetS
  df.group <- cbind(df.group, data.frame(CAD = rowMeans(df[ ,22:27])))  # 6 CAD
  df.group <- cbind(df.group, data.frame(T2D = rowMeans(df[ ,28:35])))  # 8 T2D
  df.group <- round(df.group, 2)
  row.names(df.group) <- row.names(df)
  return(df.group)
}