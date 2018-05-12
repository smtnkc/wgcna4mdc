# CORRELATION MATRIX
df.gse.cor <- df.gse.sig[ , 3:37]
row.names(df.gse.cor) <- df.gse.sig$STRING_id

# Append Spearman Score to df.plinks.sig
df.cor.ctrl <- AppendCor(df.plinks.sig, df.gse.cor, range = c(1:9), tool = "spearman")
df.cor.ra   <- AppendCor(df.plinks.sig, df.gse.cor, range = c(10:15), tool = "spearman")
df.cor.mets <- AppendCor(df.plinks.sig, df.gse.cor, range = c(16:21), tool = "spearman")
df.cor.cad  <- AppendCor(df.plinks.sig, df.gse.cor, range = c(22:27), tool = "spearman")
df.cor.t2d  <- AppendCor(df.plinks.sig, df.gse.cor, range = c(28:35), tool = "spearman")

# write.csv(df.cor.ctrl, file = "DATA/EXPORT/COR/ctrl.csv", row.names = FALSE)
# write.csv(df.cor.ra, file = "DATA/EXPORT/COR/ra.csv", row.names = FALSE)
# write.csv(df.cor.mets, file = "DATA/EXPORT/COR/mets.csv", row.names = FALSE)
# write.csv(df.cor.cad, file = "DATA/EXPORT/COR/cad.csv", row.names = FALSE)
# write.csv(df.cor.t2d, file = "DATA/EXPORT/COR/t2d.csv", row.names = FALSE)

df.map.cor <- GetMapCor(df.map, df.cor.cad)
# write.csv(df.map.cor, file = "DATA/EXPORT/COR_MAP.csv", row.names = FALSE)

# write.csv(cbind(gene1 = df.map.cor$gene1,
#                 gene2 = df.map.cor$gene2,
#                 combined_score = df.cor.ctrl$combined_score,
#                 spearman_score = df.cor.ctrl$spearman_score),
#           file = "DATA/EXPORT/COR/ctrl_gene.csv", row.names = FALSE)
# 
# write.csv(cbind(gene1 = df.map.cor$gene1,
#                 gene2 = df.map.cor$gene2,
#                 combined_score = df.cor.ra$combined_score,
#                 spearman_score = df.cor.ra$spearman_score),
#           file = "DATA/EXPORT/COR/ra_gene.csv", row.names = FALSE)
# 
# write.csv(cbind(gene1 = df.map.cor$gene1,
#                 gene2 = df.map.cor$gene2,
#                 combined_score = df.cor.cad$combined_score,
#                 spearman_score = df.cor.cad$spearman_score),
#           file = "DATA/EXPORT/COR/cad_gene.csv", row.names = FALSE)
# 
# write.csv(cbind(gene1 = df.map.cor$gene1,
#                 gene2 = df.map.cor$gene2,
#                 combined_score = df.cor.mets$combined_score,
#                 spearman_score = df.cor.mets$spearman_score),
#           file = "DATA/EXPORT/COR/mets_gene.csv", row.names = FALSE)
# 
# write.csv(cbind(gene1 = df.map.cor$gene1,
#                 gene2 = df.map.cor$gene2,
#                 combined_score = df.cor.t2d$combined_score,
#                 spearman_score = df.cor.t2d$spearman_score),
#           file = "DATA/EXPORT/COR/t2d_gene.csv", row.names = FALSE)

# Filter insignificant relations according to 2-tailed test values (for alpha = 0.05)
df.cor.ctrl.sig <- df.cor.ctrl[abs(df.cor.ctrl$Spearman_Score) >= 0.700, ]
df.cor.ra.sig <- df.cor.ra[abs(df.cor.ra$Spearman_Score) >= 0.886, ]
df.cor.mets.sig <- df.cor.mets[abs(df.cor.mets$Spearman_Score) >= 0.886, ]
df.cor.cad.sig <- df.cor.cad[abs(df.cor.cad$Spearman_Score) >= 0.886, ]
df.cor.t2d.sig <- df.cor.t2d[abs(df.cor.t2d$Spearman_Score) >= 0.738, ]

# write.csv(df.cor.ctrl.sig, file = "DATA/EXPORT/COR/ctrl_sig.csv", row.names = FALSE)
# write.csv(df.cor.ra.sig, file = "DATA/EXPORT/COR/ra_sig.csv", row.names = FALSE)
# write.csv(df.cor.mets.sig, file = "DATA/EXPORT/COR/mets_sig.csv", row.names = FALSE)
# write.csv(df.cor.cad.sig, file = "DATA/EXPORT/COR/cad_sig.csv", row.names = FALSE)
# write.csv(df.cor.t2d.sig, file = "DATA/EXPORT/COR/t2d_sig.csv", row.names = FALSE)