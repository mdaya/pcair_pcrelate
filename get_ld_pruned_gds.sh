#!/bin/bash

#Set parameters
maf=$1
missing_rate=$2
slide_max_bp=$3
r2_ld_threshold=$4
snp_id_file=$5
out_file_prefix=$6

#Call R script

cat /home/analyst/create_ld_pruned_gds.R | R --vanilla --args \
   $maf \
   $missing_rate \
   $slide_max_bp \
   $r2_ld_threshold \
   $snp_id_file \
   $out_file_prefix \
   "${*:7}"
