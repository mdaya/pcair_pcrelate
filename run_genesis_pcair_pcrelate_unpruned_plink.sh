#!/bin/bash

#Set parameters
plink_bed_file=$1
plink_bim_file=`echo $plink_bed_file | sed 's/.bed/.bim/' | sed 's/.BED/.BIM/'`
plink_fam_file=`echo $plink_bed_file | sed 's/.bed/.fam/' | sed 's/.BED/.FAM/'`
gds_file=`echo $plink_bed_file | sed 's/.bed/.gds/' | sed 's/.BED/.gds/'`
pca_rdata_file=`basename $plink_bed_file | sed 's/.bed/_pca.RData/' | sed 's/.BED/_pca.RData/'`
km_rdata_file=`basename $plink_bed_file | sed 's/.bed/_km.RData/' | sed 's/.BED/_km.RData/'`
log_file=`basename $plink_bed_file | sed 's/.bed/_GENESIS.log/' | sed 's/.BED/_GENESIS.log/'`
maf=$2
missing_rate=$3
slide_max_bp=$4
r2_ld_threshold=$5
nr_pcs=$6
concat_fid_iid=$7

#Call R script

cat /home/analyst/GENESIS_PCAIR_PCRELATE_UNPRUNED_PLINK.R | R --vanilla --args \
   $plink_bed_file \
   $plink_bim_file \
   $plink_fam_file \
   $gds_file \
   $pca_rdata_file \
   $km_rdata_file \
   $log_file \
   $maf \
   $missing_rate \
   $slide_max_bp \
   $r2_ld_threshold \
   $nr_pcs \
   $concat_fid_iid
