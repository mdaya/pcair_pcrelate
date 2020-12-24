class: Workflow
cwlVersion: v1.1
label: ' pcair_pcrelate_unpruned_gds'
doc: A workflow to generate PC-Air aand PC-relate output for the GENESIS association test pipeline, given a list of GDS (e.g. chr 1-22) originally converted from an imputed VCF file, a list of info.gz files from the Michigan imputation server for obtaining Rsq per variant, and an initial set of variants that are not in LD (e.g. the list provided by TOPMed)
$namespaces:
  sbg: https://sevenbridges.com

requirements:
- class: InlineJavascriptRequirement
- class: StepInputExpressionRequirement

inputs:
- id: list_of_gds_files
  label: list_of_gds_files
  doc: |-
    List of GDS files (e.g. chr1.gds, chr2.gds, ..., chr22.gds) to perform LD pruning on
  type: File[]
  sbg:x: -235.16526794433594
  sbg:y: -257.0166931152344
- id: snp_id_file
  label: snp_id_file
  doc: A file with a list of initial LD pruned markers, e.g. from TOPMed
  type: File
  sbg:fileTypes: .txt
  sbg:x: -426
  sbg:y: -533
- id: list_of_info_files
  label: list_of_info_files
  type: File[]
  sbg:fileTypes: .info.gz
  sbg:x: -431
  sbg:y: -304
- id: out_file_prefix
  label: out_file_prefix
  doc: Prefix that should be appended to all output files
  type: string
  sbg:exposed: true
- id: out_file_prefix_1
  label: out_file_prefix
  doc: Prefix that should be appended to all output files
  type: string
  sbg:exposed: true

outputs:
- id: pca_rdata
  label: pca_rdata
  doc: .RData file containing the pca output
  type: File
  outputSource:
  - run_genesis_pcair_pcrelate_pruned_gds/pca_rdata
  sbg:fileTypes: .RData
  sbg:x: 371.2729797363281
  sbg:y: -583.7208251953125
- id: log
  label: log
  doc: Output of R script run
  type: File
  outputSource:
  - run_genesis_pcair_pcrelate_pruned_gds/log
  sbg:fileTypes: .log
  sbg:x: 374.9332275390625
  sbg:y: -443.834716796875
- id: km_rdata
  label: km_rdata
  doc: .RData file containing the kinship output
  type: File
  outputSource:
  - run_genesis_pcair_pcrelate_pruned_gds/km_rdata
  sbg:x: 379.2637634277344
  sbg:y: -304.74456787109375
- id: ld_prune_log
  label: ld_prune_log
  doc: Output of R script run
  type: string
  outputSource:
  - get_ld_pruned_gds/ld_prune_log
  sbg:x: 97.01669311523438
  sbg:y: -572.504150390625

steps:
- id: get_high_rsq_ids
  label: get_high_rsq_ids
  in:
  - id: snp_id_file
    source: snp_id_file
  - id: min_rsq
    default: 0.9
  - id: list_of_info_files
    source:
    - list_of_info_files
  run: pcair_pcrelate_unpruned_imputed_unpacked.cwl.steps/get_high_rsq_ids.cwl
  out:
  - id: high_rsq_variants
  sbg:x: -282.25543212890625
  sbg:y: -449.84307861328125
- id: get_ld_pruned_gds
  label: get_ld_pruned_gds
  in:
  - id: slide_max_bp
    default: 1000000
  - id: snp_id_file
    source: get_high_rsq_ids/high_rsq_variants
  - id: out_file_prefix
    default: study_name
    source: out_file_prefix
  - id: list_of_gds_files
    source:
    - list_of_gds_files
  run: pcair_pcrelate_unpruned_imputed_unpacked.cwl.steps/get_ld_pruned_gds.cwl
  out:
  - id: combined_gds
  - id: ld_prune_log
  sbg:x: -60.33108139038086
  sbg:y: -434.3108215332031
- id: run_genesis_pcair_pcrelate_pruned_gds
  label: run_genesis_pcair_pcrelate_pruned_gds
  in:
  - id: pruned_gds_file
    source: get_ld_pruned_gds/combined_gds
  - id: out_file_prefix
    default: study_name
    source: out_file_prefix_1
  run: |-
    pcair_pcrelate_unpruned_imputed_unpacked.cwl.steps/run_genesis_pcair_pcrelate_pruned_gds.cwl
  out:
  - id: pca_rdata
  - id: km_rdata
  - id: log
  sbg:x: 185.63865661621094
  sbg:y: -441.1680603027344
sbg:appVersion:
- v1.1
sbg:content_hash: a7aed475739a3d4681d6849c7e4d54cdbc197232b8e2625268e241f9d4887c55c
sbg:contributors:
- midaya
sbg:createdBy: midaya
sbg:createdOn: 1605731452
sbg:id: midaya/cag/pcair-pcrelate-unpruned-gds/9
sbg:image_url: |-
  https://platform.sb.biodatacatalyst.nhlbi.nih.gov/ns/brood/images/midaya/cag/pcair-pcrelate-unpruned-gds/9.png
sbg:latestRevision: 9
sbg:modifiedBy: midaya
sbg:modifiedOn: 1605832872
sbg:original_source: |-
  https://api.sb.biodatacatalyst.nhlbi.nih.gov/v2/apps/midaya/cag/pcair-pcrelate-unpruned-gds/9/raw/
sbg:project: midaya/cag
sbg:projectName: CAG
sbg:publisher: sbg
sbg:revision: 9
sbg:revisionNotes: Changed default parameter settings
sbg:revisionsInfo:
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1605731452
  sbg:revision: 0
  sbg:revisionNotes:
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1605731688
  sbg:revision: 1
  sbg:revisionNotes: Initial version
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1605732020
  sbg:revision: 2
  sbg:revisionNotes: Added default study names
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1605732127
  sbg:revision: 3
  sbg:revisionNotes: ''
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1605732299
  sbg:revision: 4
  sbg:revisionNotes: Changed app settings
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1605732403
  sbg:revision: 5
  sbg:revisionNotes: Got latest ld_pruned task
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1605732496
  sbg:revision: 6
  sbg:revisionNotes: ''
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1605734387
  sbg:revision: 7
  sbg:revisionNotes: Initial commit
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1605832790
  sbg:revision: 8
  sbg:revisionNotes: ''
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1605832872
  sbg:revision: 9
  sbg:revisionNotes: Changed default parameter settings
sbg:sbgMaintained: false
sbg:validationErrors: []
