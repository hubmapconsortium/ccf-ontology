# ----------------------------------------
# Makefile for generating instances
# of spatial entities
# ----------------------------------------

SPATIAL_FILES =\
	$(INSTANCES_DIR)/spatial_entity_instances.owl

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

$(INSTANCES_DIR)/spatial_entity_instances.owl: $(INSTANCES_DIR)/reference_3d_organs.owl \
											   $(EXTRACTS_DIR)/uberon_spatial.owl \
											   $(EXTRACTS_DIR)/fma_spatial.owl
	if [ $(COMP) = true ]; then $(ROBOT) merge --input $(word 1,$^) \
				--input $(word 2,$^) \
				--input $(word 3,$^) \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) \
				--output $@.tmp.owl && \
			mv -f $@.tmp.owl $@; fi
.PRECIOUS: $(INSTANCES_DIR)/spatial_entity_instances.owl

# ------------------------------------------------------------------
# Get as needed AS terms from Uberon Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/uberon_spatial.owl: $(EXTRACTS_DIR) \
		$(INSTANCES_DIR)/reference_3d_organs.owl \
		$(MIRRORDIR)/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	if [ $(EXT) = true ]; then $(ROBOT) query --input $(word 2,$^) \
				--query queries/get_uberon_entities.sparql /tmp/entity_set.csv && \
		sed -i '1d' /tmp/entity_set.csv && \
		$(ROBOT) extract --method MIREOT \
				--input $(word 3,$^) \
				--upper-term "http://purl.obolibrary.org/obo/UBERON_0001062" \
				--lower-terms /tmp/entity_set.csv \
				--intermediates $(INTERMEDIATES_OPT) \
			annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) \
				--output $@.tmp.owl && \
		mv $@.tmp.owl $@ && \
		rm /tmp/entity_set.csv; fi
.PRECIOUS: $(EXTRACTS_DIR)/uberon_spatial.owl

# ------------------------------------------------------------------
# Get as needed AS terms from FMA Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/fma_spatial.owl: $(EXTRACTS_DIR) \
		$(INSTANCES_DIR)/reference_3d_organs.owl \
		$(MIRRORDIR)/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	if [ $(EXT) = true ]; then $(ROBOT) query --input $(word 2,$^) \
				--query queries/get_fma_entities.sparql /tmp/entity_set.csv && \
		sed -i '1d' /tmp/entity_set.csv && \
		$(ROBOT) extract --method MIREOT \
				--input $(word 3,$^) \
				--upper-term "http://purl.org/sig/ont/fma/fma62955" \
				--lower-terms /tmp/entity_set.csv \
				--intermediates $(INTERMEDIATES_OPT) \
			annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) \
				--output $@.tmp.owl && \
		mv $@.tmp.owl $@ && \
		rm /tmp/entity_set.csv; fi
.PRECIOUS: $(EXTRACTS_DIR)/fma_spatial.owl
