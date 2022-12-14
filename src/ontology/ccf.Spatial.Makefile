# ----------------------------------------
# Makefile for generating instances
# of spatial entities
# ----------------------------------------

SPATIAL_FILES =\
	$(INSTANCES_DIR)/reference_3d_organs.owl

# ----------------------------------------
# Makefile for the Spatial Data
# ----------------------------------------

## Download the source data
$(INSTANCES_DIR)/reference-spatial-entities.jsonld: | $(INSTANCES_DIR)
	if [ $(INST) = true ]; then curl -L https://raw.githubusercontent.com/hubmapconsortium/hubmap-ontology/master/source_data/reference-spatial-entities.jsonld --create-dirs -o $@; fi
.PRECIOUS: $(INSTANCES_DIR)/reference-spatial-entities.jsonld

$(INSTANCES_DIR)/generated-reference-spatial-entities.jsonld: | $(INSTANCES_DIR)
	if [ $(INST) = true ]; then curl -L https://raw.githubusercontent.com/hubmapconsortium/hubmap-ontology/master/source_data/generated-reference-spatial-entities.jsonld --create-dirs -o $@; fi
.PRECIOUS: $(INSTANCES_DIR)/generated-reference-spatial-entities.jsonld


# ----------------------------------------
# Data modules
# ----------------------------------------

.PHONY: check_spatial2ccf
check_spatial2ccf:
	@type spatial2ccf > /dev/null 2>&1 || (echo "ERROR: spatial2ccf is required, please visit https://github.com/hubmapconsortium/spatial2ccf to install"; exit 1)

## GENERATE-DATA: spatial data from reference organs
$(INSTANCES_DIR)/reference_3d_organs.owl: check_spatial2ccf $(INSTANCES_DIR) \
											$(INSTANCES_DIR)/reference-spatial-entities.jsonld \
											$(INSTANCES_DIR)/generated-reference-spatial-entities.jsonld
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(INST) = true ]; then spatial2ccf $(word 3,$^) $(word 4,$^) \
		--ontology-iri $(ONTBASE)/$@ -o $@.tmp.owl && mv $@.tmp.owl $@.tmp.owl && \
		$(ROBOT) annotate --input $@.tmp.owl --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && \
		mv $@.tmp.owl $@; fi
.PRECIOUS: $(INSTANCES_DIR)/reference_3d_organs.owl
