class: CommandLineTool
cwlVersion: v1.1
label: run_genesis_pcair_pcrelate_pruned_gds
$namespaces:
  sbg: https://sevenbridges.com

requirements:
- class: ShellCommandRequirement
- class: ResourceRequirement
  coresMin: 0
  ramMin: 16
- class: DockerRequirement
  dockerPull: dayam/pcair_pcrelate:1.0

inputs:
- id: pruned_gds_file
  label: pruned_gds_file
  doc: The input GDS file containing LD pruned variants
  type: File
  inputBinding:
    position: 1
    shellQuote: false
  sbg:fileTypes: .gds
- id: nr_pcs
  label: nr_pcs
  doc: The number of PCs to use in the pcrelate kinship estimation.
  type: int?
  default: 2
  inputBinding:
    position: 2
    shellQuote: false
  sbg:toolDefaultValue: '2'
- id: out_file_prefix
  label: out_file_prefix
  doc: Prefix that should be appended to all output files
  type: string
  inputBinding:
    position: 3
    shellQuote: false

outputs:
- id: pca_rdata
  label: pca_rdata
  doc: .RData file containing the pca output
  type: File
  outputBinding:
    glob: '*_pca.RData'
  sbg:fileTypes: .RData
- id: km_rdata
  label: km_rdata
  doc: .RData file containing the kinship output
  type: File
  outputBinding:
    glob: '*_km.RData'
- id: log
  label: log
  doc: Output of R script run
  type: File
  outputBinding:
    glob: '*_GENESIS_PCA.log'
  sbg:fileTypes: .log

baseCommand:
- bash /home/analyst/run_genesis_pcair_pcrelate_pruned_gds.sh
id: midaya/cag/run-genesis-pcair-pcrelate-pruned-gds/2
sbg:appVersion:
- v1.1
sbg:content_hash: a07b766adcba7b7ec3ebaf31b7e3ca38c7b46683bfa38ebeb6564a27eee001abd
sbg:contributors:
- midaya
sbg:createdBy: midaya
sbg:createdOn: 1605730969
sbg:id: midaya/cag/run-genesis-pcair-pcrelate-pruned-gds/2
sbg:image_url:
sbg:latestRevision: 2
sbg:modifiedBy: midaya
sbg:modifiedOn: 1605832740
sbg:project: midaya/cag
sbg:projectName: CAG
sbg:publisher: sbg
sbg:revision: 2
sbg:revisionNotes: Changed default parameter settings
sbg:revisionsInfo:
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1605730969
  sbg:revision: 0
  sbg:revisionNotes:
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1605731363
  sbg:revision: 1
  sbg:revisionNotes: Initial version
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1605832740
  sbg:revision: 2
  sbg:revisionNotes: Changed default parameter settings
sbg:sbgMaintained: false
sbg:validationErrors: []
