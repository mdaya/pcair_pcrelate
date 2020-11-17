args <- commandArgs(trailingOnly = TRUE)
subset.snp.ids <- read.delim(args[1], stringsAsFactors = F)[,1]
min.rsq=as.numeric(args[2])

subset.snp.ids <- paste0("chr", subset.snp.ids)

variant.id <- data.frame()
info.gz.files <- scan(text=args[3], what="")
for (info.gz.file in info.gz.files) {
   info <- read.delim(gzfile(info.gz.file), stringsAsFactors=F)
   info$Rsq_num <- as.numeric(info$Rsq)
   extracted.rows <- (info$SNP %in% subset.snp.ids) & !is.na(info$Rsq_num) & (info$Rsq_num >= min.rsq)
   variant.id <- rbind(variant.id, data.frame(SNP=info$SNP[extracted.rows]))
}

write.table(variant.id$SNP, file="high_rsq_ld_pruned_variants.txt",  sep="\t", quote=F, row.names=F, col.names=F)

