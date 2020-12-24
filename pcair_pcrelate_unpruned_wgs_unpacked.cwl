class: Workflow
cwlVersion: v1.1
label: pcair_pcrelate_unpruned_wgs
$namespaces:
  sbg: https://sevenbridges.com

requirements:
- class: InlineJavascriptRequirement
- class: StepInputExpressionRequirement

inputs:
- id: snp_id_file
  label: snp_id_file
  doc: A file with a list of initial LD pruned markers, e.g. from TOPMed
  type: File
  sbg:x: -461.7111511230469
  sbg:y: -253.334228515625
- id: list_of_gds_files
  label: list_of_gds_files
  doc: |-
    List of GDS files (e.g. chr1.gds, chr2.gds, ..., chr22.gds) to perform LD pruning on
  type: File[]
  sbg:fileTypes: .gds
  sbg:x: -456.71429443359375
  sbg:y: -60.28571319580078
- id: out_file_prefix_1
  label: out_file_prefix
  doc: Prefix that should be appended to all output files
  type: string
  sbg:exposed: true
- id: out_file_prefix
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
  sbg:x: 136.8602752685547
  sbg:y: -299.7627868652344
- id: log
  label: log
  doc: Output of R script run
  type: File
  outputSource:
  - run_genesis_pcair_pcrelate_pruned_gds/log
  sbg:fileTypes: .log
  sbg:x: 139.2857208251953
  sbg:y: -186
- id: km_rdata
  label: km_rdata
  doc: .RData file containing the kinship output
  type: File
  outputSource:
  - run_genesis_pcair_pcrelate_pruned_gds/km_rdata
  sbg:x: 145.57142639160156
  sbg:y: -46.85714340209961
- id: ld_prune_log
  label: ld_prune_log
  doc: Output of R script run
  type: string
  outputSource:
  - get_ld_pruned_gds/ld_prune_log
  sbg:x: -181.14285278320312
  sbg:y: -316.1428527832031

steps:
- id: get_ld_pruned_gds
  label: get_ld_pruned_gds
  in:
  - id: min_maf
    default: 0.01
  - id: max_missing_rate
    default: 0.01
  - id: slide_max_bp
    default: 1000000
  - id: r2_ld_threshold
    default: 0.1
  - id: snp_id_file
    source: snp_id_file
  - id: out_file_prefix
    default: study_name
    source: out_file_prefix_1
  - id: list_of_gds_files
    source:
    - list_of_gds_files
  run: pcair_pcrelate_unpruned_wgs_unpacked.cwl.steps/get_ld_pruned_gds.cwl
  out:
  - id: combined_gds
  - id: ld_prune_log
  sbg:x: -319
  sbg:y: -183
- id: run_genesis_pcair_pcrelate_pruned_gds
  label: run_genesis_pcair_pcrelate_pruned_gds
  in:
  - id: pruned_gds_file
    source: get_ld_pruned_gds/combined_gds
  - id: nr_pcs
    default: 2
  - id: out_file_prefix
    default: study_name
    source: out_file_prefix
  run: |-
    pcair_pcrelate_unpruned_wgs_unpacked.cwl.steps/run_genesis_pcair_pcrelate_pruned_gds.cwl
  out:
  - id: pca_rdata
  - id: km_rdata
  - id: log
  sbg:x: -47.85714340209961
  sbg:y: -186.2857208251953
sbg:appVersion:
- v1.1
sbg:content_hash: a0a833a7bd5851606b8a260a7ac98634acdf0523346c25e64a7924c0daddf2085
sbg:contributors:
- midaya
sbg:createdBy: midaya
sbg:createdOn: 1605747046
sbg:id: midaya/sarp-bdc/pcair-pcrelate-unpruned-wgs/3
sbg:image_url: |-
  https://platform.sb.biodatacatalyst.nhlbi.nih.gov/ns/brood/images/midaya/sarp-bdc/pcair-pcrelate-unpruned-wgs/3.png
sbg:latestRevision: 3
sbg:modifiedBy: midaya
sbg:modifiedOn: 1605832961
sbg:original_source: |-
  https://api.sb.biodatacatalyst.nhlbi.nih.gov/v2/apps/midaya/sarp-bdc/pcair-pcrelate-unpruned-wgs/3/raw/
sbg:project: midaya/sarp-bdc
sbg:projectName: SARP_BDC
sbg:publisher: sbg
sbg:revision: 3
sbg:revisionNotes: Changed default values
sbg:revisionsInfo:
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1605747046
  sbg:revision: 0
  sbg:revisionNotes:
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1605747351
  sbg:revision: 1
  sbg:revisionNotes: Initial version
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1605747415
  sbg:revision: 2
  sbg:revisionNotes: Fixed missing parameter
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1605832961
  sbg:revision: 3
  sbg:revisionNotes: Changed default values
sbg:sbgMaintained: false
sbg:validationErrors: []
