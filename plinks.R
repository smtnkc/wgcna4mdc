# STEP 0: Initialization
df.plinks.all     <- NULL
df.plinks.mapped  <- NULL
df.plinks.sig     <- NULL
v.proteins.all    <- NULL
v.proteins.mapped <- NULL
v.proteins.sig    <- NULL

# STEP 1: Get all plinks from STRINGdb
df.plinks.all <- as.data.frame(fread("DATA/PLINKS.tsv", header = TRUE, sep = ' '))[, c(1, 2, 16)]
v.proteins.all <- unique(as.vector(rbind(df.plinks.all$protein1, df.plinks.all$protein2)))

# STEP 2: Filter out proteins which does not exist in df.gse.mapped
df.plinks.mapped <- df.plinks.all[df.plinks.all$protein1 %in% df.gse.mapped$STRING_id, ]
df.plinks.mapped <- df.plinks.mapped[df.plinks.mapped$protein2 %in% df.gse.mapped$STRING_id, ]
v.proteins.mapped <- unique(as.vector(rbind(df.plinks.mapped$protein1, df.plinks.mapped$protein2)))

# STEP 3: Filter out insignificant plinks where combined score < 700
df.plinks.sig <- df.plinks.mapped[df.plinks.mapped$combined_score >= 700, ]
v.proteins.sig <- unique(as.vector(rbind(df.plinks.sig$protein1, df.plinks.sig$protein2)))