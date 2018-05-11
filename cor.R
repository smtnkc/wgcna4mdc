# CORRELATION MATRIX
df.gse.cor <- df.gse.sig[ , 3:37]
row.names(df.gse.cor) <- df.gse.sig$STRING_id

# Append Spearman Score to df.plinks.sig
df.edgelist.ctrl <- AppendCor(df.plinks.sig, df.gse.cor, range = c(1:9),   tool = "spearman")
df.edgelist.ra   <- AppendCor(df.plinks.sig, df.gse.cor, range = c(10:15), tool = "spearman")
df.edgelist.mets <- AppendCor(df.plinks.sig, df.gse.cor, range = c(16:21), tool = "spearman")
df.edgelist.cad  <- AppendCor(df.plinks.sig, df.gse.cor, range = c(22:27), tool = "spearman")
df.edgelist.t2d  <- AppendCor(df.plinks.sig, df.gse.cor, range = c(28:35), tool = "spearman")

# write.csv(df.edgelist.ctrl, file = "DATA/EXPORT/COR/ctrl.csv", row.names = FALSE)
# write.csv(df.edgelist.ra, file = "DATA/EXPORT/COR/ra.csv", row.names = FALSE)
# write.csv(df.edgelist.mets, file = "DATA/EXPORT/COR/mets.csv", row.names = FALSE)
# write.csv(df.edgelist.cad, file = "DATA/EXPORT/COR/cad.csv", row.names = FALSE)
# write.csv(df.edgelist.t2d, file = "DATA/EXPORT/COR/t2d.csv", row.names = FALSE)

# Filter insignificant relations according to 2-tailed test values (for alpha = 0.05)
df.edgelist.ctrl.sig <- df.edgelist.ctrl[abs(df.edgelist.ctrl$Spearman_Score) >= 0.700, ]
df.edgelist.ra.sig <- df.edgelist.ra[abs(df.edgelist.ra$Spearman_Score) >= 0.886, ]
df.edgelist.mets.sig <- df.edgelist.mets[abs(df.edgelist.mets$Spearman_Score) >= 0.886, ]
df.edgelist.cad.sig <- df.edgelist.cad[abs(df.edgelist.cad$Spearman_Score) >= 0.886, ]
df.edgelist.t2d.sig <- df.edgelist.t2d[abs(df.edgelist.t2d$Spearman_Score) >= 0.738, ]

# write.csv(df.edgelist.ctrl.sig, file = "DATA/EXPORT/COR/ctrl_sig.csv", row.names = FALSE)
# write.csv(df.edgelist.ra.sig, file = "DATA/EXPORT/COR/ra_sig.csv", row.names = FALSE)
# write.csv(df.edgelist.mets.sig, file = "DATA/EXPORT/COR/mets_sig.csv", row.names = FALSE)
# write.csv(df.edgelist.cad.sig, file = "DATA/EXPORT/COR/cad_sig.csv", row.names = FALSE)
# write.csv(df.edgelist.t2d.sig, file = "DATA/EXPORT/COR/t2d_sig.csv", row.names = FALSE)