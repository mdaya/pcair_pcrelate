#!/bin/bash

#Set parameters
pruned_gds_file=$1
nr_pcs=$2
out_file_prefix=$3

#Call R script
cat /home/analyst/GENESIS_PCAIR_PCRELATE_PRUNED_GDS.R | R --vanilla --args \
   $pruned_gds_file \
   $nr_pcs \
   $out_file_prefix
