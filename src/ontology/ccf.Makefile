## Customize Makefile settings for ccf
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile

# ----------------------------------------
# Top-level targets
# ----------------------------------------

.PHONY: all_things
all_things: odkversion all_imports all_data all_main all_subsets sparql_test all_reports all_assets


# ----------------------------------------
# Import modules
# ----------------------------------------
# Most ontologies are modularly constructed using portions of other ontologies
# These live in the imports/ folder

## ONTOLOGY: fma
imports/fma_import.owl: mirror/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -L imports/fma_terms.txt --force true --copy-ontology-annotations true --individuals include --method MIREOT \
		remove --axioms structural-tautologies \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

## Copy of fma is re-downloaded whenever source changes
mirror/fma.trigger: $(SRC)
mirror/fma.owl: mirror/fma.trigger
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading fma.owl)
	if [ $(MIR) = true ] && [ $(IMP) = true ]; then wget -nc https://data.bioontology.org/ontologies/FMA/download\?apikey\=$(BIOPORTAL_API_KEY)\&download_format\=rdf -O $@.tmp.owl && \
			$(ROBOT) annotate -i $@.tmp.owl --ontology-iri http://purl.org/sig/ont/fma.owl --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: mirror/fma.owl

## ONTOLOGY: obi
imports/obi_import.owl: mirror/obi.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -u OBI:0100051 -L imports/obi_terms.txt --force true --copy-ontology-annotations true --individuals exclude --method MIREOT \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

## ONTOLOGY: hgnc
imports/hgnc_import.owl: mirror/hgnc.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -L imports/hgnc_terms.txt --force true --copy-ontology-annotations true --individuals exclude --method MIREOT \
		remove --axioms structural-tautologies \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

## Copy of hgnc is re-downloaded whenever source changes
mirror/hgnc.trigger: $(SRC)
mirror/hgnc.owl: mirror/hgnc.trigger
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading hgnc.owl)
	if [ $(MIR) = true ] && [ $(IMP) = true ]; then wget -nc https://data.bioontology.org/ontologies/HGNC/download\?apikey\=$(BIOPORTAL_API_KEY)\&download_format\=rdf -O $@.tmp.owl && \
			$(ROBOT) annotate -i $@.tmp.owl --ontology-iri http://ncicb.nci.nih.gov/xml/owl/EVS/Hugo.owl --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: mirror/hgnc.owl

## ONTOLOGY: efo
imports/efo_import.owl: mirror/efo.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -u http://www.ebi.ac.uk/efo/EFO_0002694 -L imports/efo_terms.txt --force true --copy-ontology-annotations true --individuals include --method MIREOT \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

## Copy of efo is re-downloaded whenever source changes
mirror/efo.trigger: $(SRC)
mirror/efo.owl: mirror/efo.trigger
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading efo.owl)
	if [ $(MIR) = true ] && [ $(IMP) = true ]; then wget -nc https://data.bioontology.org/ontologies/EFO/download\?apikey\=$(BIOPORTAL_API_KEY)\&download_format\=rdf -O $@.tmp.owl && \
			$(ROBOT) annotate -i $@.tmp.owl --ontology-iri http://www.ebi.ac.uk/efo.owl --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: mirror/efo.owl

## ONTOLOGY: loinc
imports/loinc_import.owl: mirror/loinc.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(IMP) = true ] && [ $(IMP_LARGE) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -L imports/loinc_terms.txt --force true --copy-ontology-annotations true --individuals exclude --method MIREOT \
		remove --axioms structural-tautologies \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

## Copy of loinc is re-downloaded whenever source changes
mirror/loinc.trigger: $(SRC)
mirror/loinc.owl: mirror/loinc.trigger
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading loinc.owl)
	if [ $(MIR) = true ] && [ $(IMP) = true ] && [ $(IMP_LARGE) = true ]; then wget -nc https://data.bioontology.org/ontologies/LOINC/download\?apikey\=$(BIOPORTAL_API_KEY)\&download_format\=rdf -O $@.tmp.owl && \
			$(ROBOT) annotate -i $@.tmp.owl --ontology-iri http://purl.bioontology.org/ontology/LNC/loinc.owl --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: mirror/loinc.owl


# ----------------------------------------
# Data modules
# ----------------------------------------

DATADIR = data

DATA = asctb spatial_entities
DATA_FILES = $(patsubst %, $(DATADIR)/%.owl, $(DATA))

.PHONY: all_data
all_data: $(DATA_FILES)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Finish generating data files:)
	$(foreach n, $(DATA_FILES), $(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: - $(n)))

.PHONY: check
check:
	@type cedar2ccf > /dev/null 2>&1 || (echo "ERROR: cedar2ccf is required, please visit https://github.com/hubmapconsortium/cedar2ccf to install"; exit 1)
	@type rui2ccf > /dev/null 2>&1 || (echo "ERROR: rui2ccf is required, please visit https://github.com/hubmapconsortium/rui2ccf to install"; exit 1)

## GENERATE-DATA: asctb

data/asctb.owl: check
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	cedar2ccf data/cedar-templates.txt --ontology-iri $(ONTBASE)/$@ -o $@

## GENERATE-DATA: spatial_entities

data/spatial_entities.owl: check
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	rui2ccf https://raw.githubusercontent.com/hubmapconsortium/hubmap-ontology/master/source_data/generated-reference-spatial-entities.jsonld \
        https://raw.githubusercontent.com/hubmapconsortium/hubmap-ontology/master/source_data/reference-spatial-entities.jsonld \
        --ontology-iri $(ONTBASE)/$@ -o $@