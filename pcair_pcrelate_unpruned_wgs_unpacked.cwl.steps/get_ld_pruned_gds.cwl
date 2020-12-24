class: CommandLineTool
cwlVersion: v1.1
label: get_ld_pruned_gds
$namespaces:
  sbg: https://sevenbridges.com

requirements:
- class: ShellCommandRequirement
- class: DockerRequirement
  dockerPull: dayam/pcair_pcrelate:1.0

inputs:
- id: min_maf
  label: min_maf
  doc: |-
    The minimum MAF a variant should have to be included in the output GDS (corresponds to the maf parameter in the snpgdsSelectSNP function from the SNPRelate R package). Recommended value: 0.01
  type: float?
  default: 0.01
  inputBinding:
    position: 1
    shellQuote: false
  sbg:toolDefaultValue: '0.01'
- id: max_missing_rate
  label: max_missing_rate
  doc: |-
    The maximum missing genotype proportion a variant may have to be included in the output GDS (corresponds to the missing.rate parameter in the snpgdsSelectSNP function from the SNPRelate R package). Recommended value: 0.01
  type: float?
  default: 0.01
  inputBinding:
    position: 2
    shellQuote: false
  sbg:toolDefaultValue: '0.01'
- id: slide_max_bp
  label: slide_max_bp
  doc: |-
    Window size in base pairs that should be used for LD Pruning prior to performing PCA (corresponds to the slide.max.bp parameter for the snpgdsLDpruning function from the SNPRelate R package). Recommended value: 1000000
  type: int?
  default: 1000000
  inputBinding:
    position: 3
    shellQuote: false
  sbg:toolDefaultValue: '1000000'
- id: r2_ld_threshold
  label: r2_ld_threshold
  doc: |-
    The LD threshold (the square root of this value will be passed to the ld.threshold parameter of the snpgdsLDpruning function from the SNPRelate R package). Recommended value: 0.1
  type: float?
  default: 0.1
  inputBinding:
    position: 4
    shellQuote: false
  sbg:toolDefaultValue: '0.1'
- id: snp_id_file
  label: snp_id_file
  doc: A file with a list of initial LD pruned markers, e.g. from TOPMed
  type: File
  inputBinding:
    position: 5
    shellQuote: false
- id: out_file_prefix
  label: out_file_prefix
  doc: Prefix that should be appended to all output files
  type: string
  inputBinding:
    position: 6
    shellQuote: false
- id: list_of_gds_files
  label: list_of_gds_files
  doc: |-
    List of GDS files (e.g. chr1.gds, chr2.gds, ..., chr22.gds) to perform LD pruning on
  type: File[]
  inputBinding:
    position: 7
    shellQuote: false
  sbg:fileTypes: .gds

outputs:
- id: combined_gds
  label: combined_gds
  doc: A combined GDS file with LD pruned markers
  type: File
  outputBinding:
    glob: '*_combined_pruned.gds'
  sbg:fileTypes: .gds
- id: ld_prune_log
  label: ld_prune_log
  doc: Output of R script run
  type: string
  outputBinding:
    glob: ld_prune.log

baseCommand:
- bash /home/analyst/get_ld_pruned_gds.sh
id: midaya/cag/get-ld-pruned-gds/4
sbg:appVersion:
- v1.1
sbg:content_hash: ad6373500d4f8445c9b5c7036379dbf0995e16d1b61b4f3a077b320129545cb2d
sbg:contributors:
- midaya
sbg:createdBy: midaya
sbg:createdOn: 1605730466
sbg:id: midaya/cag/get-ld-pruned-gds/4
sbg:image_url:
sbg:latestRevision: 4
sbg:modifiedBy: midaya
sbg:modifiedOn: 1605832684
sbg:project: midaya/cag
sbg:projectName: CAG
sbg:publisher: sbg
sbg:revision: 4
sbg:revisionNotes: Changed parameter setting of default parameters to be optional
sbg:revisionsInfo:
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1605730466
  sbg:revision: 0
  sbg:revisionNotes:
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1605730902
  sbg:revision: 1
  sbg:revisionNotes: Initial version
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1605732344
  sbg:revision: 2
  sbg:revisionNotes: added file type for gds
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1605732430
  sbg:revision: 3
  sbg:revisionNotes: Fixed file type
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1605832684
  sbg:revision: 4
  sbg:revisionNotes: Changed parameter setting of default parameters to be optional
sbg:sbgMaintained: false
sbg:validationErrors: []
