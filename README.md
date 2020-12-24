A docker environment and calling scripts to run GENESIS PC-AiR and PC-relate on
SevenBridges

The docker build can be pulled from https://quay.io/repository/mdaya/pcair_pcrelate

To perform LD pruning and then PCA on an unpruned PLINK file, 
run the following command from the docker instance:

```
bash /home/analyst/run_genesis_pcair_pcrelate_unpruned_plink.sh \
   plink_bed_file \
   min_maf \
   max_missing_rate \
   slide_max_bp \
   r2_ld_threshold \
   nr_pcs \
   concat_fid_iid
```

Given a list of variant IDs (e.g. a list of LD pruned markers from TOPMed), 
and a set of imputed info.gz file, get a subset of markers that have Rsq greater
than the given threshold:

```
bash /home/analyst/get_high_rsq_ids.sh \
   snp_id_file \
   min_rsq \
   list_of_info_files
```

Given a list of GDS files (1 per chromosome), and a list of variant IDs 
(e.g. a list of LD pruned markers from TOPMed), extract those variants, 
apply some filters, and generate a combined LD pruned GDS file:

```
bash /home/analyst/get_ld_pruned_gds.sh \
   min_maf \
   max_missing_rate \
   slide_max_bp \
   r2_ld_threshold \
   snp_id_file \
   out_file_prefix \
   list_of_gds_files
```

To perform LD pruning and then PCA on a pruned GDS file:

```
bash /home/analyst/run_genesis_pcair_pcrelate_pruned_gds.sh \
   pruned_gds_file \
   nr_pcs \
   out_file_prefix
```

## get\_high\_rsq\_ids parameters

All parameters are mandatory and should be specified in order

### Input

#### snp\_id\_file

A file with a list of initial LD pruned markers, e.g. from TOPMed

#### min\_rsq

The minimum Rsq value a variant should have to be included in the output file

### Output

A file called high\_rsq\_ld\_pruned\_variants.txt 

## get\_ld\_pruned\_gds parameters

### Input

All parameters are mandatory and should be specified in order

#### min\_maf 

The minimum MAF a variant should have to be included in the output GDS
(corresponds to the maf parameter in the snpgdsSelectSNP function from the
SNPRelate R package). Recommended value: 0.01
   
#### max\_missing\_rate 
   
The maximum missing genotype proportion a variant may have to be included in the
output GDS
(corresponds to the missing.rate parameter in the snpgdsSelectSNP function from the
SNPRelate R package). Recommended value: 0.01

#### slide\_max\_bp 

Window size in base pairs that should be used for LD Pruning prior to performing 
PCA (corresponds to the slide.max.bp parameter for the snpgdsLDpruning function 
from the SNPRelate R package). Recommended value: 1000000
   
#### r2\_ld\_threshold 

The LD threshold (the square root of this value will be passed to the ld.threshold 
parameter of the snpgdsLDpruning function from the SNPRelate R package).
Recommended value: 0.1
   
#### snp\_id\_file 

A file with a list of initial LD pruned markers, e.g. from TOPMed
   
#### out\_file\_prefix 

Prefix that should be appended to all output files

#### list\_of\_gds\_files

List of GDS files (e.g. chr1.gds, chr2.gds, ..., chr22.gds) to perform LD
pruning on

### Output

* out\_file\_prefix\_combined\_pruned.gds
* ld\_prune.log

## run\_genesis\_pcair\_pcrelate\_pruned\_gds

### Input

#### pruned\_gds\_file

The input GDS file containing LD pruned variants

#### nr\_pcs

The number of PCs to use in the pcrelate kinship estimation.

#### out\_file\_prefix 

Prefix that should be appended to all output files

### Output

* out\_file\_prefix\_pca.RData
* out\_file\_prefix\_km.RData
* out\_file\_prefix\_GENESIS\_PCA.log

