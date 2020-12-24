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
  doc: The minimum Rsq value a variant should have to be included in the output file
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
