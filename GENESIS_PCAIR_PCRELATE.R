#Set parameters
args <- commandArgs(trailingOnly = TRUE)
bed.fn <- args[1]
bim.fn <- args[2]
fam.fn <- args[3]
gds.fn <- args[4]
pca.rdata.out.fn <- args[5]
km.rdata.out.fn <- args[6]
log.fn <- args[7]
maf <- as.numeric(args[8])
missing.rate <- as.numeric(args[9])
slide.max.bp <- as.numeric(args[10])
r2.ld.threshold <- as.numeric(args[11])
nr.pcs <- as.numeric(args[12])

#Load librariess
library(SNPRelate)
library(GWASTools)
library(GENESIS)

#Open the log file
sink(log.fn)

#Convert PLINK files to GDS files
snpgdsBED2GDS(bed.fn = bed.fn, 
              bim.fn = bim.fn, 
              fam.fn = fam.fn, 
              out.gdsfn = gds.fn)

#Filter out variants with low MAF and high missingness
gds <- snpgdsOpen(gds.fn)
snpset <- snpgdsSelectSNP(gds, maf=maf, missing.rate=missing.rate)
filtered <- unlist(snpset, use.names=FALSE)
print(paste0("Number of SNPs after MAF and missing filtereing: ", length(filtered)))

#Set seed for LD pruning
set.seed(100)

#Perform LD pruning
snpset <- snpgdsLDpruning(gds, snp.id=filtered, method="corr", slide.max.bp=slide.max.bp, 
                          ld.threshold=sqrt(r2.ld.threshold), verbose=FALSE)
pruned <- unlist(snpset, use.names=FALSE)
print(paste0("Number of SNPs after LD pruning: ", length(pruned)))

#Get KING relatedness estimates
ibd <- snpgdsIBDKING(gds, snp.id=pruned)
colnames(ibd$kinship) <- ibd$sample.id
rownames(ibd$kinship) <- ibd$sample.id

#Close the GDS file so it can be read again for PC-AiR
snpgdsClose(gds)

#Run PC-AiR
geno <- GdsGenotypeReader(filename=gds.fn)
geno.data <- GenotypeData(geno)
pca <- pcair(geno.data, 
                       kinobj=ibd$kinship,
                       divobj=ibd$kinship,
                       snp.include=pruned)


#Run PC-Relate
geno.data <- GenotypeBlockIterator(geno.data, snpInclude=pruned)
pc.relate <- pcrelate(geno.data, pcs = pca$vectors[,1:nr.pcs], 
                       training.set = pca$unrels)
km <- pcrelateToMatrix(pc.relate)


#Write PC-AiR output
save(pca, file=pca.rdata.out.fn)
save(km, file=km.rdata.out.fn)

#Close the GDS file and log file
close(geno.data)
sink()
