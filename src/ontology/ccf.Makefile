## Customize Makefile settings for ccf
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile

# ----------------------------------------
# Top-level targets
# ----------------------------------------

.PHONY: all_things
all_things: odkversion all_imports all_data all_templates all_main all_subsets sparql_test all_reports all_assets


# ----------------------------------------
# Import modules
# ----------------------------------------
# Most ontologies are modularly constructed using portions of other ontologies
# These live in the imports/ folder

IMPORTSDIR = imports
MIRRORDIR = mirror

## ONTOLOGY: uberon
$(IMPORTSDIR)/uberon_import.owl: $(MIRRORDIR)/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -u "obo:UBERON_0001062" -L imports/uberon_terms.txt --force true --copy-ontology-annotations true --method MIREOT \
		remove --axioms structural-tautologies \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

## ONTOLOGY: cl
$(IMPORTSDIR)/cl_import.owl: $(MIRRORDIR)/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -u "obo:CL_0000000" -L imports/cl_terms.txt --force true --copy-ontology-annotations true --method MIREOT \
		remove --axioms structural-tautologies \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

## ONTOLOGY: fma
$(IMPORTSDIR)/fma_import.owl: $(MIRRORDIR)/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -u "fma:fma62955" -L imports/fma_terms.txt --force true --copy-ontology-annotations true --method MIREOT \
		remove --axioms structural-tautologies \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

## Copy of fma is re-downloaded whenever source changes
$(MIRRORDIR)/fma.trigger: $(SRC)
$(MIRRORDIR)/fma.owl: $(MIRRORDIR)/fma.trigger
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading fma.owl)
	if [ $(MIR) = true ] && [ $(IMP) = true ]; then wget -nc https://data.bioontology.org/ontologies/FMA/download\?apikey\=$(BIOPORTAL_API_KEY)\&download_format\=rdf -O $@.tmp.owl && \
			$(ROBOT) annotate -i $@.tmp.owl --ontology-iri http://purl.org/sig/ont/fma.owl --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: $(MIRRORDIR)/fma.owl

## ONTOLOGY: obi
$(IMPORTSDIR)/obi_import.owl: mirror/obi.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -u OBI:0100051 -L imports/obi_terms.txt --force true --copy-ontology-annotations true --individuals exclude --method MIREOT \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

## ONTOLOGY: hgnc
$(IMPORTSDIR)/hgnc_import.owl: $(MIRRORDIR)/hgnc.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -L imports/hgnc_terms.txt --force true --copy-ontology-annotations true --individuals exclude --method MIREOT \
		remove --axioms structural-tautologies \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

## Copy of hgnc is re-downloaded whenever source changes
$(MIRRORDIR)/hgnc.trigger: $(SRC)
$(MIRRORDIR)/hgnc.owl: $(MIRRORDIR)/hgnc.trigger
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading hgnc.owl)
	if [ $(MIR) = true ] && [ $(IMP) = true ]; then wget -nc https://data.bioontology.org/ontologies/HGNC/download\?apikey\=$(BIOPORTAL_API_KEY)\&download_format\=rdf -O $@.tmp.owl && \
			$(ROBOT) annotate -i $@.tmp.owl --ontology-iri http://ncicb.nci.nih.gov/xml/owl/EVS/Hugo.owl --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: $(MIRRORDIR)/hgnc.owl

## ONTOLOGY: efo
$(IMPORTSDIR)/efo_import.owl: $(MIRRORDIR)/efo.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -u http://www.ebi.ac.uk/efo/EFO_0002694 -L imports/efo_terms.txt --force true --copy-ontology-annotations true --individuals include --method MIREOT \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

## Copy of efo is re-downloaded whenever source changes
$(MIRRORDIR)/efo.trigger: $(SRC)
$(MIRRORDIR)/efo.owl: $(MIRRORDIR)/efo.trigger
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading efo.owl)
	if [ $(MIR) = true ] && [ $(IMP) = true ]; then wget -nc https://data.bioontology.org/ontologies/EFO/download\?apikey\=$(BIOPORTAL_API_KEY)\&download_format\=rdf -O $@.tmp.owl && \
			$(ROBOT) annotate -i $@.tmp.owl --ontology-iri http://www.ebi.ac.uk/efo.owl --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: $(MIRRORDIR)/efo.owl

## ONTOLOGY: loinc
$(IMPORTSDIR)/loinc_import.owl: $(MIRRORDIR)/loinc.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(IMP) = true ] && [ $(IMP_LARGE) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -L imports/loinc_terms.txt --force true --copy-ontology-annotations true --individuals exclude --method MIREOT \
		remove --axioms structural-tautologies \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

## Copy of loinc is re-downloaded whenever source changes
$(MIRRORDIR)/loinc.trigger: $(SRC)
$(MIRRORDIR)/loinc.owl: $(MIRRORDIR)/loinc.trigger
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading loinc.owl)
	if [ $(MIR) = true ] && [ $(IMP) = true ] && [ $(IMP_LARGE) = true ]; then wget -nc https://data.bioontology.org/ontologies/LOINC/download\?apikey\=$(BIOPORTAL_API_KEY)\&download_format\=rdf -O $@.tmp.owl && \
			$(ROBOT) annotate -i $@.tmp.owl --ontology-iri http://purl.bioontology.org/ontology/LNC/loinc.owl --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: $(MIRRORDIR)/loinc.owl


# ----------------------------------------
# Component modules
# ----------------------------------------

COMPONENTSDIR = components

COMPONENTS = ccf_as_ct ccf_kidney ccf_heart ccf_brain
COMPONENT_FILES = $(patsubst %, $(COMPONENTSDIR)/%.owl, $(COMPONENTS))

COMP = true

.PHONY: all_components
all_components: $(COMPONENT_FILES)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Finish generating component files:)
	$(foreach n, $(COMPONENT_FILES), $(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: - $(n)))

## DOWNLOAD-COMPONENT: CCF_AS_CT
$(COMPONENTSDIR)/ccf_as_ct.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading CCF_AS_CT.owl)
	wget -nc https://raw.githubusercontent.com/hubmapconsortium/ccf-validation-tools/master/owl/CCF_AS_CT.owl -O $@.tmp.owl && \
	$(ROBOT) annotate -i $@.tmp.owl --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@;
.PRECIOUS: $(COMPONENTSDIR)/ccf_as_ct.owl

.PHONY: check_asctb2ccf
check_asctb2ccf:
	@type asctb2ccf > /dev/null 2>&1 || (echo "ERROR: asctb2ccf is required, please visit https://github.com/hubmapconsortium/asctb2ccf to install"; exit 1)

define generate_cell_biomarkers_component
	if [ $(COMP) = true ]; then asctb2ccf --organ-name $(1) --ontology-iri $(ONTBASE)/$@ -o $@.tmp.owl && \
		$(ROBOT) annotate --input $@.tmp.owl --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi
endef

## GENERATE-DATA: ccf_kidney
$(COMPONENTSDIR)/ccf_kidney.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_cell_biomarkers_component, Kidney)
.PRECIOUS: $(COMPONENTSDIR)/ccf_kidney.owl

## GENERATE-DATA: ccf_heart
$(COMPONENTSDIR)/ccf_heart.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_cell_biomarkers_component, Heart)
.PRECIOUS: $(COMPONENTSDIR)/ccf_heart.owl

## GENERATE-DATA: ccf_brain
$(COMPONENTSDIR)/ccf_brain.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_cell_biomarkers_component, Brain)
.PRECIOUS: $(COMPONENTSDIR)/ccf_heart.owl

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

EXT = true

.PHONY: all_extracts
all_extracts: $(UBERON_EXTRACT_FILES) $(FMA_EXTRACT_FILES) $(CL_EXTRACT_FILES)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Finish generating extract files:)
	$(foreach n, $(UBERON_EXTRACT_FILES), $(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: - $(n)))
	$(foreach n, $(FMA_EXTRACT_FILES), $(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: - $(n)))
	$(foreach n, $(CL_EXTRACT_FILES), $(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: - $(n)))

INTERMEDIATES_OPT = none

define extract_uberon_terms
	if [ $(EXT) = true ]; then $(ROBOT) query --input $(1) --query queries/get_uberon_entities.sparql /tmp/entities.csv && \
		sed -i '' 1d /tmp/entities.csv && \
		$(ROBOT) extract --method MIREOT --input $(2) --upper-term "obo:UBERON_0001062" --lower-terms /tmp/entities.csv --intermediates $(INTERMEDIATES_OPT) \
		  		 annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@ && \
		rm /tmp/entities.csv; fi
endef

define extract_fma_terms
	if [ $(EXT) = true ]; then $(ROBOT) query --input $(1) --query queries/get_fma_entities.sparql /tmp/entities.csv && \
		sed -i '' 1d /tmp/entities.csv && \
		$(ROBOT) extract --method MIREOT --input $(2) --upper-term "fma:fma62955" --lower-terms /tmp/entities.csv --intermediates $(INTERMEDIATES_OPT) \
		  		 annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@ && \
		rm /tmp/entities.csv; fi
endef

define extract_cl_terms
	if [ $(EXT) = true ]; then $(ROBOT) query --input $(1) --query queries/get_cl_entities.sparql /tmp/entities.csv && \
		sed -i '' 1d /tmp/entities.csv && \
		$(ROBOT) extract --method MIREOT --input $(2) --upper-term "obo:CL_0000000" --lower-terms /tmp/entities.csv --intermediates $(INTERMEDIATES_OPT) \
		  		 annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@ && \
		rm /tmp/entities.csv; fi
endef

## GENERATE-DATA: uberon_kidney
$(EXTRACTSDIR)/uberon_kidney.owl: $(COMPONENTSDIR)/ccf_kidney.owl $(MIRRORDIR)/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms, $(word 1, $^), $(word 2, $^))
.PRECIOUS: $(EXTRACTSDIR)/uberon_kidney.owl

## GENERATE-DATA: uberon_heart
$(EXTRACTSDIR)/uberon_heart.owl: $(COMPONENTSDIR)/ccf_heart.owl $(MIRRORDIR)/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms, $(word 1, $^), $(word 2, $^))
.PRECIOUS: $(EXTRACTSDIR)/uberon_heart.owl

## GENERATE-DATA: uberon_brain
$(EXTRACTSDIR)/uberon_brain.owl: $(COMPONENTSDIR)/ccf_brain.owl $(MIRRORDIR)/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms, $(word 1, $^), $(word 2, $^))
.PRECIOUS: $(EXTRACTSDIR)/uberon_brain.owl

# ----------------------------------------

## GENERATE-DATA: fma_heart
$(EXTRACTSDIR)/fma_heart.owl: $(COMPONENTSDIR)/ccf_heart.owl $(MIRRORDIR)/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_fma_terms, $(word 1, $^), $(word 2, $^))
.PRECIOUS: $(EXTRACTSDIR)/fma_heart.owl

# ----------------------------------------

## GENERATE-DATA: cl_kidney
$(EXTRACTSDIR)/cl_kidney.owl: $(COMPONENTSDIR)/ccf_kidney.owl $(MIRRORDIR)/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms, $(word 1, $^), $(word 2, $^))
.PRECIOUS: $(EXTRACTSDIR)/cl_kidney.owl

## GENERATE-DATA: cl_heart
$(EXTRACTSDIR)/cl_heart.owl: $(COMPONENTSDIR)/ccf_heart.owl $(MIRRORDIR)/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms, $(word 1, $^), $(word 2, $^))
.PRECIOUS: $(EXTRACTSDIR)/cl_heart.owl


# ----------------------------------------
# Data modules
# ----------------------------------------

DATADIR = data

DATA = reference_spatial_entities
DATA_FILES = $(patsubst %, $(DATADIR)/%.owl, $(DATA))

DAT = true

.PHONY: all_data
all_data: $(DATA_FILES)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Finish generating data files:)
	$(foreach n, $(DATA_FILES), $(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: - $(n)))


## GENERATE-DATA: reference_spatial_entities

.PHONY: check_rui2ccf
check_rui2ccf:
	@type rui2ccf > /dev/null 2>&1 || (echo "ERROR: rui2ccf is required, please visit https://github.com/hubmapconsortium/rui2ccf to install"; exit 1)

$(DATADIR)/reference_spatial_entities.owl: check_rui2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(DAT) = true ]; then rui2ccf https://raw.githubusercontent.com/hubmapconsortium/hubmap-ontology/master/source_data/generated-reference-spatial-entities.jsonld \
        https://raw.githubusercontent.com/hubmapconsortium/hubmap-ontology/master/source_data/reference-spatial-entities.jsonld \
        --ontology-iri $(ONTBASE)/$@ -o $@.tmp.owl && mv $@.tmp.owl $@.tmp.owl && \
		$(ROBOT) annotate --input $@.tmp.owl --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: $(DATADIR)/reference_spatial_entities.owl
