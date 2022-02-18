## Customize Makefile settings for CCF ontology
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile

CCF_BSO = $(ONT)-bso
CCF_SCO = $(ONT)-sco
CCF_SPO = $(ONT)-spo
CCF = $(ONT)

CCF_BSO_SRC = $(CCF_BSO)-edit.owl
CCF_SCO_SRC = $(CCF_SCO)-edit.owl
CCF_SPO_SRC = $(CCF_SPO)-edit.owl
CCF_SRC = $(CCF)-edit.owl

# ----------------------------------------
# Component modules
# ----------------------------------------

COMPONENTSDIR = components

ASCTB_ORGANS = kidney heart brain

ASCTB_FILES = $(patsubst %, $(COMPONENTSDIR)/asctb_%.owl, $(ASCTB_ORGANS))

COMP = true

.PHONY: all_components
all_components: $(ASCTB_FILES)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Finish making component files:)
	$(foreach n, $(ASCTB_FILES), $(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: - $(n)))

define make_asctb_component
	if [ $(COMP) = true ]; then $(ROBOT) annotate -i $(COMPONENTSDIR)/$(1) --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv -f $@.tmp.owl $@; fi
endef

$(COMPONENTSDIR)/asctb_kidney.owl: $(COMPONENTSDIR)/ccf_partonomy_kidney.owl $(COMPONENTSDIR)/ccf_cell_biomarkers_kidney.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,asctb_kidney-edit.owl)
.PRECIOUS: $(COMPONENTSDIR)/asctb_kidney.owl

$(COMPONENTSDIR)/asctb_heart.owl: $(COMPONENTSDIR)/ccf_partonomy_heart.owl $(COMPONENTSDIR)/ccf_cell_biomarkers_heart.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,asctb_heart-edit.owl)
.PRECIOUS: $(COMPONENTSDIR)/asctb_heart.owl

$(COMPONENTSDIR)/asctb_brain.owl: $(COMPONENTSDIR)/ccf_partonomy_brain.owl $(COMPONENTSDIR)/ccf_cell_biomarkers_brain.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,asctb_brain-edit.owl )
.PRECIOUS: $(COMPONENTSDIR)/asctb_brain.owl

# ----

PARTONOMY_FILES = $(patsubst %, $(COMPONENTSDIR)/ccf_partonomy_%.owl, $(ASCTB_ORGANS))

define download_ccf_partonomy_component
	if [ $(COMP) = true ]; then wget -nc https://raw.githubusercontent.com/hubmapconsortium/ccf-validation-tools/master/owl/ccf_${1}_classes.owl -O $@.tmp.owl && \
		$(ROBOT) annotate -i $@.tmp.owl --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi
endef

## DOWNLOAD-COMPONENT: CCF_AS_CT
# $(COMPONENTSDIR)/ccf_as_ct.owl:
# 	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
# 	wget -nc https://raw.githubusercontent.com/hubmapconsortium/ccf-validation-tools/master/owl/CCF_AS_CT.owl -O $@.tmp.owl && \
# 	$(ROBOT) annotate -i $@.tmp.owl --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@;
# .PRECIOUS: $(COMPONENTSDIR)/ccf_as_ct.owl

## DOWNLOAD-FILE: ccf_partonomy_kidney
$(COMPONENTSDIR)/ccf_partonomy_kidney.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Kidney)
.PRECIOUS: $(COMPONENTSDIR)/ccf_partonomy_kidney.owl

## DOWNLOAD-FILE: ccf_partonomy_heart
$(COMPONENTSDIR)/ccf_partonomy_heart.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Heart)
.PRECIOUS: $(COMPONENTSDIR)/ccf_partonomy_heart.owl

## DOWNLOAD-FILE: ccf_partonomy_brain
$(COMPONENTSDIR)/ccf_partonomy_brain.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Brain)
.PRECIOUS: $(COMPONENTSDIR)/ccf_partonomy_brain.owl

# ----------

CELL_BIOMARKER_FILES = $(patsubst %, $(COMPONENTSDIR)/ccf_cell_biomarker_%.owl, $(ASCTB_ORGANS))

.PHONY: check_asctb2ccf
check_asctb2ccf:
	@type asctb2ccf > /dev/null 2>&1 || (echo "ERROR: asctb2ccf is required, please visit https://github.com/hubmapconsortium/asctb2ccf to install"; exit 1)

define generate_ccf_cell_biomarkers_component
	if [ $(COMP) = true ]; then asctb2ccf --organ-name $(1) --ontology-iri $(ONTBASE)/$@ -o $@.tmp.owl && \
		$(ROBOT) annotate --input $@.tmp.owl --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi
endef

## GENERATE-DATA: ccf_cell_biomarkers_kidney
$(COMPONENTSDIR)/ccf_cell_biomarkers_kidney.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,Kidney)
.PRECIOUS: $(COMPONENTSDIR)/ccf_cell_biomarkers_kidney.owl

## GENERATE-DATA: ccf_cell_biomarkers_heart
$(COMPONENTSDIR)/ccf_cell_biomarkers_heart.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,Heart)
.PRECIOUS: $(COMPONENTSDIR)/ccf_cell_biomarkers_heart.owl

## GENERATE-DATA: ccf_cell_biomarkers_brain
$(COMPONENTSDIR)/ccf_cell_biomarkers_brain.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,Brain)
.PRECIOUS: $(COMPONENTSDIR)/ccf_cell_biomarkers_brain.owl


COMPONENT_FILES =\
	$(ASCTB_FILES) \
	$(PARTONOMY_FILES) \
	$(CL_EXTRACT_FILES)

# ----------------------------------------
# Extract modules
# ----------------------------------------

EXTRACTSDIR = extracts

UBERON_EXTRACTS = uberon_kidney uberon_heart uberon_brain
UBERON_EXTRACT_FILES = $(patsubst %, $(EXTRACTSDIR)/%.owl, $(UBERON_EXTRACTS))

FMA_EXTRACTS = fma_heart
FMA_EXTRACT_FILES = $(patsubst %, $(EXTRACTSDIR)/%.owl, $(FMA_EXTRACTS))

CL_EXTRACTS = cl_kidney cl_heart
CL_EXTRACT_FILES = $(patsubst %, $(EXTRACTSDIR)/%.owl, $(CL_EXTRACTS))

EXTRACT_FILES = \
	$(UBERON_EXTRACT_FILES) \
	$(FMA_EXTRACT_FILES) \
	$(CL_EXTRACT_FILES)

EXT = true

.PHONY: all_extracts
all_extracts: $(UBERON_EXTRACT_FILES) $(FMA_EXTRACT_FILES) $(CL_EXTRACT_FILES)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Finish generating extract files:)
	$(foreach n, $(UBERON_EXTRACT_FILES), $(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: - $(n)))
	$(foreach n, $(FMA_EXTRACT_FILES), $(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: - $(n)))
	$(foreach n, $(CL_EXTRACT_FILES), $(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: - $(n)))

INTERMEDIATES_OPT = none

define extract_uberon_terms
	if [ $(EXT) = true ]; then $(ROBOT) merge --input $(1) \
			query --query queries/get_uberon_entities.sparql /tmp/entities.csv && \
		sed -i '' 1d /tmp/entities.csv && \
		$(ROBOT) extract --method MIREOT --input $(2) --upper-term "obo:UBERON_0001062" --lower-terms /tmp/entities.csv --intermediates $(INTERMEDIATES_OPT) \
		  		 annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@ && \
		rm /tmp/entities.csv; fi
endef

define extract_fma_terms
	if [ $(EXT) = true ]; then $(ROBOT) merge --input $(1) \
	    	query --query queries/get_fma_entities.sparql /tmp/entities.csv && \
		sed -i '' 1d /tmp/entities.csv && \
		$(ROBOT) extract --method MIREOT --input $(2) --upper-term "http://purl.org/sig/ont/fma/fma62955" --lower-terms /tmp/entities.csv --intermediates $(INTERMEDIATES_OPT) \
		  		 annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@ && \
		rm /tmp/entities.csv; fi
endef

define extract_cl_terms
	if [ $(EXT) = true ]; then $(ROBOT) merge --input $(1) \
	    	query --query queries/get_cl_entities.sparql /tmp/entities.csv && \
		sed -i '' 1d /tmp/entities.csv && \
		$(ROBOT) extract --method MIREOT --input $(2) --upper-term "obo:CL_0000000" --lower-terms /tmp/entities.csv --intermediates $(INTERMEDIATES_OPT) \
		  		 annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@ && \
		rm /tmp/entities.csv; fi
endef

## GENERATE-DATA: uberon_kidney
$(EXTRACTSDIR)/uberon_kidney.owl: $(COMPONENTSDIR)/asctb_kidney.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms, $(word 1, $^), $(word 2, $^))
.PRECIOUS: $(EXTRACTSDIR)/uberon_kidney.owl

## GENERATE-DATA: uberon_heart
$(EXTRACTSDIR)/uberon_heart.owl: $(COMPONENTSDIR)/asctb_heart.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms, $(word 1, $^), $(word 2, $^))
.PRECIOUS: $(EXTRACTSDIR)/uberon_heart.owl

## GENERATE-DATA: uberon_brain
$(EXTRACTSDIR)/uberon_brain.owl: $(COMPONENTSDIR)/asctb_brain.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms, $(word 1, $^), $(word 2, $^))
.PRECIOUS: $(EXTRACTSDIR)/uberon_brain.owl

# ----------------------------------------

## GENERATE-DATA: fma_heart
$(EXTRACTSDIR)/fma_heart.owl: $(COMPONENTSDIR)/asctb_heart.owl mirror/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_fma_terms, $(word 1, $^), $(word 2, $^))
.PRECIOUS: $(EXTRACTSDIR)/fma_heart.owl

# ----------------------------------------

## GENERATE-DATA: cl_kidney
$(EXTRACTSDIR)/cl_kidney.owl: $(COMPONENTSDIR)/asctb_kidney.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms, $(word 1, $^), $(word 2, $^))
.PRECIOUS: $(EXTRACTSDIR)/cl_kidney.owl

## GENERATE-DATA: cl_heart
$(EXTRACTSDIR)/cl_heart.owl: $(COMPONENTSDIR)/asctb_heart.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms, $(word 1, $^), $(word 2, $^))
.PRECIOUS: $(EXTRACTSDIR)/cl_heart.owl


# ----------------------------------------
# Data sources Module
# ----------------------------------------

DATASOURCESDIR = data/sources

DATASRC = reference-spatial-entities generated-reference-spatial-entities hubmap-datasets
DATASRC_FILES = $(patsubst %, $(DATASOURCESDIR)/%.jsonld, $(DATASRC))

DATSRC = true

$(DATASOURCESDIR)/reference-spatial-entities.jsonld:
	if [ $(DATSRC) = true ]; then wget -nc https://raw.githubusercontent.com/hubmapconsortium/hubmap-ontology/master/source_data/reference-spatial-entities.jsonld -O $@; fi
.PRECIOUS: $(DATASOURCESDIR)/reference-spatial-entities.jsonld

$(DATASOURCESDIR)/generated-reference-spatial-entities.jsonld:
	if [ $(DATSRC) = true ]; then wget -nc https://raw.githubusercontent.com/hubmapconsortium/hubmap-ontology/master/source_data/generated-reference-spatial-entities.jsonld -O $@; fi
.PRECIOUS: $(DATASOURCESDIR)/generated-reference-spatial-entities.jsonld

$(DATASOURCESDIR)/hubmap-datasets.jsonld:
	if [ $(DATSRC) = true ]; then wget -nc https://hubmap-link-api.herokuapp.com/hubmap-datasets?format=jsonld -O $@; fi
.PRECIOUS: $(DATASOURCESDIR)/hubmap-datasets.jsonld


# ----------------------------------------
# Data modules
# ----------------------------------------

DATADIR = data

DATA = reference_spatial_entities specimen_spatial_entities specimen_dataset
DATA_FILES = $(patsubst %, $(DATADIR)/%.owl, $(DATA))

DAT = true

.PHONY: all_data
all_data: $(DATA_FILES)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Finish generating data files:)
	$(foreach n, $(DATA_FILES), $(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: - $(n)))


## GENERATE-DATA: reference_spatial_entities

.PHONY: check_spatial2ccf
check_spatial2ccf:
	@type spatial2ccf > /dev/null 2>&1 || (echo "ERROR: spatial2ccf is required, please visit https://github.com/hubmapconsortium/spatial2ccf to install"; exit 1)

.PHONY: check_specimen2ccf
check_specimen2ccf:
	@type specimen2ccf > /dev/null 2>&1 || (echo "ERROR: specimen2ccf is required, please visit https://github.com/hubmapconsortium/specimen2ccf to install"; exit 1)

$(DATADIR)/reference_spatial_entities.owl: check_spatial2ccf $(DATASOURCESDIR)/reference-spatial-entities.jsonld $(DATASOURCESDIR)/generated-reference-spatial-entities.jsonld
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(DAT) = true ]; then spatial2ccf $(DATASOURCESDIR)/reference-spatial-entities.jsonld \
        $(DATASOURCESDIR)/generated-reference-spatial-entities.jsonld \
        --ontology-iri $(ONTBASE)/$@ -o $@.tmp.owl && mv $@.tmp.owl $@.tmp.owl && \
		$(ROBOT) annotate --input $@.tmp.owl --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: $(DATADIR)/reference_spatial_entities.owl

$(DATADIR)/specimen_spatial_entities.owl: check_spatial2ccf $(DATASOURCESDIR)/hubmap-datasets.jsonld
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(DAT) = true ]; then spatial2ccf $(DATASOURCESDIR)/hubmap-datasets.jsonld \
        --ontology-iri $(ONTBASE)/$@ -o $@.tmp.owl && mv $@.tmp.owl $@.tmp.owl && \
		$(ROBOT) annotate --input $@.tmp.owl --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: $(DATADIR)/specimen_spatial_entities.owl

$(DATADIR)/specimen_dataset.owl: check_specimen2ccf $(DATASOURCESDIR)/hubmap-datasets.jsonld
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(DAT) = true ]; then specimen2ccf data/sources/hubmap-datasets.jsonld \
        --ontology-iri $(ONTBASE)/$@ -o $@.tmp.owl && mv $@.tmp.owl $@.tmp.owl && \
		$(ROBOT) annotate --input $@.tmp.owl --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: $(DATADIR)/specimen_dataset.owl


# ----------------------------------------
# Prepare the ontology components
# ----------------------------------------

.PHONY: prepare_ccf_bso
prepare_ccf_bso: $(ASCTB_FILES) $(EXTRACT_FILES)

.PHONY: prepare_ccf_sco
prepare_ccf_sco: $(DATADIR)/specimen_dataset.owl

.PHONY: prepare_ccf_spo
prepare_ccf_spo: $(DATADIR)/reference_spatial_entities.owl $(DATADIR)/specimen_spatial_entities.owl

.PHONY: prepare_ccf
prepare_ccf: $(ASCTB_FILES) $(EXTRACT_FILES) $(DATA_FILES)

# ----------------------------------------
# Create the releases
# ----------------------------------------

CCF_ARTEFACTS = $(CCF_BSO) $(CCF_SCO) $(CCF_SPO) $(CCF)
CCF_ARTEFACT_FILES = $(patsubst %, %.owl, $(CCF_ARTEFACTS))

.PHONY: release_all_ccf
release_all_ccf: $(CCF_ARTEFACT_FILES)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating a release for all CCF artifacts)
	mv $^ $(RELEASEDIR)

.PHONY: release_ccf_bso
release_ccf_bso: $(CCF-BSO).owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating a release for CCF Biological Structure (CCF-BSO) ontology)
	mv $^ $(RELEASEDIR)

.PHONY: release_ccf_sco
release_ccf_sco: $(CCF-SCO).owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating a release for CCF Specimen (CCF-SCO) ontology)
	mv $^ $(RELEASEDIR)

.PHONY: release_ccf_spo
release_ccf_spo: $(CCF-SPO).owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating a release for CCF Spatial (CCF-SPO) ontology)
	mv $^ $(RELEASEDIR)

.PHONY: release_ccf
release_ccf: $(CCF).owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating a release for CCF ontology)
	mv $^ $(RELEASEDIR)


# ----------------------------------------
# Create the ontology
# ----------------------------------------

.PHONY: ccf_bso
ccf_bso: $(ONT)-bso.owl

$(ONT)-bso.owl: $(CCF_BSO_SRC)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating CCF Biological Structure (CCF-BSO) ontology)
	$(ROBOT) merge --input $< \
		reason --reasoner ELK --equivalent-classes-allowed all --exclude-tautologies structural \
		relax \
		reduce -r ELK \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@
.PRECIOUS: $(ONT)-bso.owl

.PHONY: ccf_sco
ccf_sco: $(ONT)-sco.owl

$(ONT)-sco.owl: $(CCF_SCO_SRC)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating CCF Specimen (CCF-SCO) ontology)
	$(ROBOT) merge --input $< \
		reason --reasoner ELK --equivalent-classes-allowed all --exclude-tautologies structural \
		relax \
		reduce -r ELK \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@
.PRECIOUS: $(ONT)-sco.owl

.PHONY: ccf_spo
ccf_spo: $(ONT)-spo.owl

$(ONT)-spo.owl: $(CCF_SPO_SRC)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating CCF Spatial (CCF-SPO) ontology)
	$(ROBOT) merge --input $< \
		reason --reasoner ELK --equivalent-classes-allowed all --exclude-tautologies structural \
		relax \
		reduce -r ELK \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@
.PRECIOUS: $(ONT)-spo.owl

.PHONY: ccf
ccf: $(ONT)-bso.owl $(ONT)-sco.owl $(ONT)-spo.owl $(ONT).owl 

$(ONT).owl: $(CCF_SRC)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating CCF ontology)
	$(ROBOT) merge --input $< \
		reason --reasoner ELK --equivalent-classes-allowed all --exclude-tautologies structural \
		relax \
		reduce -r ELK \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@
.PRECIOUS: $(ONT).owl


# ----------------------------------------
# Clean up
# ----------------------------------------

GENERATED_FILES = \
	$(COMPONENT_FILES) \
	$(EXTRACT_FILES) \
	$(DATA_FILES) \
	$(CCF_ARTEFACT_FILES) 

.PHONY: clean_all
clean_all: $(GENERATED_FILES)
	rm -f $^
