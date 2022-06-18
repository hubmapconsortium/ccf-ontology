#!/bin/bash

# Parse the arguments
for ARGUMENT in "$@"
do
   KEY=$(echo $ARGUMENT | cut -f1 -d=)

   KEY_LENGTH=${#KEY}
   VALUE="${ARGUMENT:$KEY_LENGTH+1}"

   export "$KEY"="$VALUE"
done

# Standardized the input string to CamelCase
ORGAN_LABEL=$(echo $ORGAN | sed 's/.*/\L&/;s/[a-z]*/\u&/g' | tr -d '-' | tr -d '[:space:]') 

# Standardized the organ name for naming the output file to snake_case
ORGAN_NAME=$(echo $ORGAN_LABEL | sed 's/[[:upper:]]/_&/g;s/^_//' | tr '[:upper:]' '[:lower:]')

VALIDATION_TOOL_ORGAN_NAME=$(tr '[:lower:]' '[:upper:]' <<< ${ORGAN_NAME:0:1})${ORGAN_NAME:1}
if [[ $ORGAN_NAME = 'bone_marrow' ]]
then
	VALIDATION_TOOL_ORGAN_NAME='Bone-Marrow'
elif [[ $ORGAN_NAME = 'spinal_cord' ]]
then
	VALIDATION_TOOL_ORGAN_NAME='Spinal_Cord'
fi

ANNOTATION_FILE=asctb_$ORGAN_NAME.ttl
if [[ ! -f $(echo annotations/$ANNOTATION_FILE) ]]
then
	ANNOTATION_FILE="asctb_default.ttl"
fi

# Generate the Makefile
echo "Creating ccf.$ORGAN_LABEL.Makefile"
cat > ccf.$ORGAN_LABEL.Makefile << EOF
# ------------------------------------------------------------------
# Get the AS Partonomy
# ------------------------------------------------------------------
\$(GENERATED_DIR)/ccf_partonomy_$ORGAN_NAME.owl: | \$(GENERATED_DIR)
	\$(info [\$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating \$@)
	\$(call download_ccf_partonomy_component,$VALIDATION_TOOL_ORGAN_NAME)
.PRECIOUS: \$(GENERATED_DIR)/ccf_partonomy_$ORGAN_NAME.owl

# ------------------------------------------------------------------
# Get the CT+B Cell-Type Markers
# ------------------------------------------------------------------
\$(GENERATED_DIR)/ccf_cell_biomarkers_$ORGAN_NAME.owl: check_asctb2ccf \$(GENERATED_DIR)
	\$(info [\$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating \$@)
	\$(call generate_ccf_cell_biomarkers_component,$ORGAN_LABEL,$GSHEET_URL)
.PRECIOUS: \$(GENERATED_DIR)/ccf_cell_biomarkers_$ORGAN_NAME.owl

# ------------------------------------------------------------------
# Get the ASCT+B Data as annotations 
# ------------------------------------------------------------------
\$(GENERATED_DIR)/ccf_asctb_annotations_$ORGAN_NAME.owl: check_asctb2ccf \$(GENERATED_DIR)
	\$(info [\$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating \$@)
	\$(call generate_ccf_asctb_annotations_component,$ORGAN_LABEL,$GSHEET_URL)
.PRECIOUS: \$(GENERATED_DIR)/ccf_asctb_annotations_$ORGAN_NAME.owl

# ------------------------------------------------------------------
# Get as needed AS terms from Uberon Ontology
# ------------------------------------------------------------------
\$(EXTRACTS_DIR)/uberon_$ORGAN_NAME.owl: \$(EXTRACTS_DIR) \\
		\$(GENERATED_DIR)/ccf_asctb_annotations_$ORGAN_NAME.owl \\
		\$(GENERATED_DIR)/ccf_cell_biomarkers_$ORGAN_NAME.owl \\
		\$(GENERATED_DIR)/ccf_partonomy_$ORGAN_NAME.owl \\
		\$(MIRRORDIR)/uberon.owl
	\$(info [\$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting \$@)
	\$(call extract_uberon_terms,\$(word 2,\$^),\$(word 3,\$^),\$(word 4,\$^),\$(word 5,\$^))
.PRECIOUS: \$(EXTRACTS_DIR)/uberon_$ORGAN_NAME.owl

# ------------------------------------------------------------------
# Get as needed AS terms from FMA Ontology
# ------------------------------------------------------------------
\$(EXTRACTS_DIR)/fma_$ORGAN_NAME.owl: \$(EXTRACTS_DIR) \\
		\$(GENERATED_DIR)/ccf_asctb_annotations_$ORGAN_NAME.owl \\
		\$(GENERATED_DIR)/ccf_cell_biomarkers_$ORGAN_NAME.owl \\
		\$(GENERATED_DIR)/ccf_partonomy_$ORGAN_NAME.owl \\
		\$(MIRRORDIR)/fma.owl
	\$(info [\$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting \$@)
	\$(call extract_fma_terms,\$(word 2,\$^),\$(word 3,\$^),\$(word 4,\$^),\$(word 5,\$^))
.PRECIOUS: \$(EXTRACTS_DIR)/fma_$ORGAN_NAME.owl

# ------------------------------------------------------------------
# Get as needed CT terms from Cell Ontology
# ------------------------------------------------------------------
\$(EXTRACTS_DIR)/cl_$ORGAN_NAME.owl: \$(EXTRACTS_DIR) \\
		\$(GENERATED_DIR)/ccf_asctb_annotations_$ORGAN_NAME.owl \\
		\$(GENERATED_DIR)/ccf_cell_biomarkers_$ORGAN_NAME.owl \\
		\$(GENERATED_DIR)/ccf_partonomy_$ORGAN_NAME.owl \\
		\$(MIRRORDIR)/cl.owl
	\$(info [\$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting \$@)
	\$(call extract_cl_terms,\$(word 2,\$^),\$(word 3,\$^),\$(word 4,\$^),\$(word 5,\$^))
.PRECIOUS: \$(EXTRACTS_DIR)/cl_$ORGAN_NAME.owl

# ------------------------------------------------------------------
# Get as needed CT terms from LMHA Ontology
# ------------------------------------------------------------------
\$(EXTRACTS_DIR)/lmha_$ORGAN_NAME.owl: \$(EXTRACTS_DIR) \\
		\$(GENERATED_DIR)/ccf_asctb_annotations_$ORGAN_NAME.owl \\
		\$(GENERATED_DIR)/ccf_cell_biomarkers_$ORGAN_NAME.owl \\
		\$(GENERATED_DIR)/ccf_partonomy_$ORGAN_NAME.owl \\
		\$(MIRRORDIR)/lmha.owl
	\$(info [\$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting \$@)
	\$(call extract_lmha_terms,\$(word 2,\$^),\$(word 3,\$^),\$(word 4,\$^),\$(word 5,\$^))
.PRECIOUS: \$(EXTRACTS_DIR)/lmha_$ORGAN_NAME.owl

# ------------------------------------------------------------------
# Get as needed B terms from HGNC
# ------------------------------------------------------------------
\$(EXTRACTS_DIR)/hgnc_$ORGAN_NAME.owl: \$(EXTRACTS_DIR) \\
		\$(GENERATED_DIR)/ccf_asctb_annotations_$ORGAN_NAME.owl \\
		\$(GENERATED_DIR)/ccf_cell_biomarkers_$ORGAN_NAME.owl \\
		\$(GENERATED_DIR)/ccf_partonomy_$ORGAN_NAME.owl \\
		\$(MIRRORDIR)/hgnc.owl
	\$(info [\$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting \$@)
	\$(call extract_hgnc_terms,\$(word 2,\$^),\$(word 3,\$^),\$(word 4,\$^),\$(word 5,\$^))
.PRECIOUS: \$(EXTRACTS_DIR)/hgnc_$ORGAN_NAME.owl

# ------------------------------------------------------------------
# Build the ASCT+B table as an OWL ontology
# ------------------------------------------------------------------
\$(COMPONENTSDIR)/asctb_$ORGAN_NAME.owl: \$(COMPONENTSDIR) \\
		\$(GENERATED_DIR)/ccf_partonomy_$ORGAN_NAME.owl \\
		\$(GENERATED_DIR)/ccf_cell_biomarkers_$ORGAN_NAME.owl \\
		\$(GENERATED_DIR)/ccf_asctb_annotations_$ORGAN_NAME.owl \\
		\$(ANNOTATIONS_DIR)/$ANNOTATION_FILE \\
		\$(EXTRACTS_DIR)/uberon_$ORGAN_NAME.owl \\
		\$(EXTRACTS_DIR)/fma_$ORGAN_NAME.owl \\
		\$(EXTRACTS_DIR)/cl_$ORGAN_NAME.owl \\
		\$(EXTRACTS_DIR)/lmha_$ORGAN_NAME.owl \\
		\$(EXTRACTS_DIR)/hgnc_$ORGAN_NAME.owl
	\$(info [\$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making \$@)
	\$(call make_asctb_component,\$(word 2,\$^),\$(word 3,\$^),\$(word 4,\$^),\$(word 5,\$^),\$(word 6,\$^),\$(word 7,\$^),\$(word 8,\$^),\$(word 9,\$^),\$(word 10,\$^))
.PRECIOUS: \$(COMPONENTSDIR)/asctb_$ORGAN_NAME.owl
EOF

if ! grep -Fq "include ccf.$ORGAN_LABEL.Makefile" ccf.Asctb.Makefile
then
	echo "Inserting '$ORGAN_LABEL' in ccf.Asctb.Makefile"
cat >> ccf.Asctb.Makefile << EOF
include ccf.$ORGAN_LABEL.Makefile
EOF
fi

if ! grep -Fq "\$(COMPONENTSDIR)/asctb_$ORGAN_NAME.owl \\" ccf.AsctbList.Makefile;
then
	echo "Inserting '$ORGAN_LABEL' in ccf.AsctbList.Makefile"
cat >> ccf.AsctbList.Makefile << EOF
	\$(COMPONENTSDIR)/asctb_$ORGAN_NAME.owl \\
EOF
fi

if ! grep -Fq "<uri name=\"http://purl.org/ccf/components/asctb_$ORGAN_NAME.owl\" uri=\"components/asctb_$ORGAN_NAME.owl\"/>" catalog-v001.xml
then
	echo "Inserting '$ORGAN_LABEL' in catalog-v001.xml"
	sed -i "/^    <!-- ASCT+B Ontology Components -->/a \ \ \ \ <uri name=\"http:\/\/purl.org\/ccf\/components\/asctb_$ORGAN_NAME.owl\" uri=\"components\/asctb_$ORGAN_NAME.owl\"\/>" catalog-v001.xml
fi

if ! grep -Fq "Import(<http://purl.org/ccf/components/asctb_$ORGAN_NAME.owl>)" ccf-bso-edit.owl
then
	echo "Inserting '$ORGAN_LABEL' in ccf-bso-edit.owl"
	sed -i "/^# ASCT+B Ontology Components/a Import(<http:\/\/purl.org\/ccf\/components\/asctb_$ORGAN_NAME.owl>)" ccf-bso-edit.owl
fi