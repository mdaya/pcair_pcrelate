class: Workflow
cwlVersion: v1.1
label: ' pcair_pcrelate_unpruned_gds'
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
  run:
    class: CommandLineTool
    cwlVersion: v1.1
    label: get_high_rsq_ids
    $namespaces:
      sbg: https://sevenbridges.com

    requirements:
    - class: ShellCommandRequirement
    - class: ResourceRequirement
      coresMin: 1
      ramMin: 4000
    - class: DockerRequirement
      dockerPull: dayam/pcair_pcrelate:1.0

    inputs:
    - id: snp_id_file
      label: snp_id_file
      doc: A file with a list of initial LD pruned markers, e.g. from TOPMed
      type: File
      inputBinding:
        position: 1
        shellQuote: false
      sbg:fileTypes: .txt
    - id: min_rsq
      label: min_rsq
      doc: The minimum Rsq value a variant should have to be included in the output
        file
      type: float?
      default: 0.01
      inputBinding:
        position: 2
        shellQuote: false
      sbg:toolDefaultValue: '0.01'
    - id: list_of_info_files
      label: list_of_info_files
      type: File[]
      inputBinding:
        position: 3
        shellQuote: false
      sbg:fileTypes: .info.gz

    outputs:
    - id: high_rsq_variants
      label: high_rsq_variants
      doc: A file containing variants that pass the minimum Rsq threshold
      type: File?
      outputBinding:
        glob: high_rsq_ld_pruned_variants.txt

    baseCommand:
    - bash /home/analyst/get_high_rsq_ids.sh
    id: midaya/cag/get-high-rsq-ids/3
    sbg:appVersion:
    - v1.1
    sbg:content_hash: a9b137b0c48dba8ae91f35e64c52457270408485d05f8494001811abab179d68d
    sbg:contributors:
    - midaya
    sbg:createdBy: midaya
    sbg:createdOn: 1605730189
    sbg:id: midaya/cag/get-high-rsq-ids/3
    sbg:image_url:
    sbg:latestRevision: 3
    sbg:modifiedBy: midaya
    sbg:modifiedOn: 1605832578
    sbg:project: midaya/cag
    sbg:projectName: CAG
    sbg:publisher: sbg
    sbg:revision: 3
    sbg:revisionNotes: Changed default parameters to not mandatory
    sbg:revisionsInfo:
    - sbg:modifiedBy: midaya
      sbg:modifiedOn: 1605730189
      sbg:revision: 0
      sbg:revisionNotes:
    - sbg:modifiedBy: midaya
      sbg:modifiedOn: 1605730446
      sbg:revision: 1
      sbg:revisionNotes: Initial version
    - sbg:modifiedBy: midaya
      sbg:modifiedOn: 1605734316
      sbg:revision: 2
      sbg:revisionNotes: Initial commit
    - sbg:modifiedBy: midaya
      sbg:modifiedOn: 1605832578
      sbg:revision: 3
      sbg:revisionNotes: Changed default parameters to not mandatory
    sbg:sbgMaintained: false
    sbg:validationErrors: []
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
  run:
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
  run:
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
  out:
  - id: pca_rdata
  - id: km_rdata
  - id: log
  sbg:x: 185.63865661621094
  sbg:y: -441.1680603027344
id: |-
  https://api.sb.biodatacatalyst.nhlbi.nih.gov/v2/apps/midaya/cag/pcair-pcrelate-unpruned-gds/9/raw/
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
