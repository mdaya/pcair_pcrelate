#!/bin/bash

snp_id_file=$1
min_rsq=$2

cat /home/analyst/get_high_rsq_ids.R | R --vanilla --args $snp_id_file $min_rsq $out_file_name "${*:3}"
