# ----------------------------------------
# Makefile for the Spatial Data
# ----------------------------------------

## Download the source data
$(DATA_MIRROR_DIR)/reference-spatial-entities.jsonld: | $(DATA_MIRROR_DIR)
	if [ $(DATMIR) = true ]; then curl -L https://raw.githubusercontent.com/hubmapconsortium/hubmap-ontology/master/source_data/reference-spatial-entities.jsonld --create-dirs -o $@; fi
.PRECIOUS: $(DATA_MIRROR_DIR)/reference-spatial-entities.jsonld

$(DATA_MIRROR_DIR)/generated-reference-spatial-entities.jsonld: | $(DATA_MIRROR_DIR)
	if [ $(DATMIR) = true ]; then curl -L https://raw.githubusercontent.com/hubmapconsortium/hubmap-ontology/pbi-ccf-v1.9/source_data/generated-reference-spatial-entities.jsonld --create-dirs -o $@; fi
.PRECIOUS: $(DATA_MIRROR_DIR)/generated-reference-spatial-entities.jsonld


# ----------------------------------------
# Data modules
# ----------------------------------------

.PHONY: check_spatial2ccf
check_spatial2ccf:
	@type spatial2ccf > /dev/null 2>&1 || (echo "ERROR: spatial2ccf is required, please visit https://github.com/hubmapconsortium/spatial2ccf to install"; exit 1)

## GENERATE-DATA: spatial data from reference organs
$(DATA_DIR)/reference_spatial_entities.owl: check_spatial2ccf $(DATA_DIR) \
											$(DATA_MIRROR_DIR)/reference-spatial-entities.jsonld \
											$(DATA_MIRROR_DIR)/generated-reference-spatial-entities.jsonld
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(DAT) = true ]; then spatial2ccf $(word 3,$^) $(word 4,$^) \
		--ontology-iri $(ONTBASE)/$@ -o $@.tmp.owl && mv $@.tmp.owl $@.tmp.owl && \
		$(ROBOT) annotate --input $@.tmp.owl --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && \
		mv $@.tmp.owl $@; fi
.PRECIOUS: $(DATA_DIR)/reference_spatial_entities.owl

## GENERATE-DATA: spatial data from sample registration datasets
$(DATA_DIR)/specimen_spatial_entities.owl: check_spatial2ccf $(DATA_DIR) \
											$(DATA_MIRROR_DIR)/hubmap-datasets.jsonld \
										   	$(DATA_MIRROR_DIR)/kpmp-datasets.jsonld \
										   	$(DATA_MIRROR_DIR)/sparc-datasets.jsonld \
										   	$(DATA_MIRROR_DIR)/gtex-datasets.jsonld
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(DAT) = true ]; then spatial2ccf $(word 3,$^) $(word 4,$^) $(word 5,$^) $(word 6,$^) \
		--ontology-iri $(ONTBASE)/$@ -o $@.tmp.owl && mv $@.tmp.owl $@.tmp.owl && \
		$(ROBOT) annotate --input $@.tmp.owl --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv \
		$@.tmp.owl $@; fi
.PRECIOUS: $(DATA_DIR)/specimen_spatial_entities.owl
