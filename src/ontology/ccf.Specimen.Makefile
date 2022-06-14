# ----------------------------------------
# Makefile for the Specimen Data
# ----------------------------------------

$(DATA_MIRROR_DIR)/hubmap-datasets.jsonld: | $(DATA_MIRROR_DIR)
	if [ $(DATMIR) = true ]; then curl -L https://ccf-api.hubmapconsortium.org/v1/hubmap/rui_locations.jsonld --create-dirs -o $@; fi
.PRECIOUS: $(DATA_MIRROR_DIR)/hubmap-datasets.jsonld

$(DATA_MIRROR_DIR)/kpmp-datasets.jsonld: | $(DATA_MIRROR_DIR)
	if [ $(DATMIR) = true ]; then curl -L https://raw.githubusercontent.com/hubmapconsortium/ccf-ui/main/projects/ccf-eui/src/assets/kpmp/data/rui_locations.jsonld --create-dirs -o $@; fi
.PRECIOUS: $(DATA_MIRROR_DIR)/kpmp-datasets.jsonld

$(DATA_MIRROR_DIR)/sparc-datasets.jsonld: | $(DATA_MIRROR_DIR)
	if [ $(DATMIR) = true ]; then curl -L https://raw.githubusercontent.com/hubmapconsortium/ccf-ui/main/projects/ccf-eui/src/assets/sparc/data/rui_locations.jsonld --create-dirs -o $@; fi
.PRECIOUS: $(DATA_MIRROR_DIR)/sparc-datasets.jsonld

$(DATA_MIRROR_DIR)/gtex-datasets.jsonld: | $(DATA_MIRROR_DIR)
	if [ $(DATMIR) = true ]; then curl -L https://raw.githubusercontent.com/hubmapconsortium/ccf-ui/main/projects/ccf-eui/src/assets/gtex/data/rui_locations.jsonld --create-dirs -o $@; fi
.PRECIOUS: $(DATA_MIRROR_DIR)/gtex-datasets.jsonld


# ----------------------------------------
# Data modules
# ----------------------------------------

.PHONY: check_specimen2ccf
check_specimen2ccf:
	@type specimen2ccf > /dev/null 2>&1 || (echo "ERROR: specimen2ccf is required, please visit https://github.com/hubmapconsortium/specimen2ccf to install"; exit 1)

## GENERATE-DATA: specimen data from sample data
$(DATA_DIR)/specimen_dataset.owl: check_specimen2ccf $(DATA_DIR) \
									$(DATA_MIRROR_DIR)/hubmap-datasets.jsonld \
								   	$(DATA_MIRROR_DIR)/kpmp-datasets.jsonld \
								   	$(DATA_MIRROR_DIR)/sparc-datasets.jsonld \
								   	$(DATA_MIRROR_DIR)/gtex-datasets.jsonld
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(DAT) = true ]; then specimen2ccf $(word 3,$^) $(word 4,$^) $(word 5,$^) $(word 6,$^) \
		--ontology-iri $(ONTBASE)/$@ -o $@.tmp.owl && mv $@.tmp.owl $@.tmp.owl && \
		$(ROBOT) annotate --input $@.tmp.owl --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: $(DATA_DIR)/specimen_dataset.owl
