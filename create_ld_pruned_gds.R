#Set parameters
args <- commandArgs(trailingOnly = TRUE)
maf <- as.numeric(args[1])
missing.rate <- as.numeric(args[2])
slide.max.bp <- as.numeric(args[3])
r2.ld.threshold <- as.numeric(args[4])
subset.snp.ids <- read.delim(args[5], stringsAsFactors = F)[,1]
out.file.prefix <- args[6]
gds.files <- c()

#Load librariess
library(SNPRelate)
library(SeqArray)
library(GWASTools)

sink("ld_prune.log")

#Process GDS files
gds.in.files <- scan(text=args[7], what="")
for (gds.in.file in gds.in.files) {
  #Setup for the file
  gds.out.file <- paste0("pruned_", basename(gds.in.file))
  print(paste("Processing", gds.in.file, "to", gds.out.file))
  
  #Get list of matching variant IDs
  gds <- seqOpen(gds.in.file)
  variant.ids <- seqGetData(gds, "variant.id")
  chromosome <- seqGetData(gds, "chromosome")
  position <- seqGetData(gds, "position")
  alleles <- gsub(",", ":", seqGetData(gds, "allele"))
  snp.ids <- paste(chromosome, position, alleles, sep=":")

  #Perform SNP list, MAF and missing rate filter
  snpset <- snpgdsSelectSNP(gds, snp.id=variant.ids[snp.ids %in% subset.snp.ids], maf=maf, missing.rate=missing.rate)
  filtered <- unlist(snpset, use.names=FALSE)
  
  #Perform LD pruning
  set.seed(100) 
  snpset <- snpgdsLDpruning(gds, snp.id=filtered, method="corr", slide.max.bp=slide.max.bp, 
                            ld.threshold=sqrt(r2.ld.threshold), verbose=FALSE)
  pruned <- unlist(snpset, use.names=FALSE)
  
  #Subset the file
  seqSetFilter(gds, variant.id=pruned)
  seqGDS2SNP(gds, gds.out.file)
  seqClose(gds)
  gds.files <- c(gds.files, gds.out.file)
}

#Write the new combined pruned GDS files 
snpgdsCombineGeno(gds.files, paste0(out.file.prefix, "_combined_pruned.gds"))

sink()


