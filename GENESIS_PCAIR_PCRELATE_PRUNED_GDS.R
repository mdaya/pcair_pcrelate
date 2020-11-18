#Set parameters
args <- commandArgs(trailingOnly = TRUE)
gds.fn <- args[1]
nr.pcs <- as.numeric(args[2])
out.file.prefix <- args[3]
log.fn <- paste0(out.file.prefix, "_GENESIS_PCA.log")
pca.rdata.out.fn <- paste0(out.file.prefix, "_pca.RData")
km.rdata.out.fn <- paste0(out.file.prefix, "_km.RData")

#Load librariess
library(SNPRelate)
library(GWASTools)
library(GENESIS)

#Open the log file
sink(log.fn)

#Get KING relatedness estimates
gds <- snpgdsOpen(gds.fn)
ibd <- snpgdsIBDKING(gds)
colnames(ibd$kinship) <- ibd$sample.id
rownames(ibd$kinship) <- ibd$sample.id

#Close the GDS file so it can be read again for PC-AiR
snpgdsClose(gds)

#Run PC-AiR
geno <- GdsGenotypeReader(filename=gds.fn)
geno.data <- GenotypeData(geno)
pca <- pcair(geno.data, 
                       kinobj=ibd$kinship,
                       divobj=ibd$kinship)


#Run PC-Relate
geno.data <- GenotypeBlockIterator(geno.data)
pc.relate <- pcrelate(geno.data, pcs = pca$vectors[,1:nr.pcs], 
                       training.set = pca$unrels)
km <- pcrelateToMatrix(pc.relate)


#Write PC-AiR output
save(pca, file=pca.rdata.out.fn)
save(km, file=km.rdata.out.fn)

#Close the GDS file and log file
close(geno.data)
sink()
