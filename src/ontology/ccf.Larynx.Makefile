# ------------------------------------------------------------------
# Get the CCF Validation Tool Output
# ------------------------------------------------------------------
# $(GENERATED_DIR)/ccf_validation_larynx.owl: | $(GENERATED_DIR)
# 	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
# 	$(call download_ccf_validation_owl,Larynx)
# .PRECIOUS: $(GENERATED_DIR)/ccf_validation_larynx.owl

# $(GENERATED_DIR)/ccf_validation_extended_larynx.owl: | $(GENERATED_DIR)
# 	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
# 	$(call download_ccf_validation_extended_owl,Larynx)
# .PRECIOUS: $(GENERATED_DIR)/ccf_validation_extended_larynx.owl

# ------------------------------------------------------------------
# Get the CT+B Cell-Type Markers
# ------------------------------------------------------------------
# $(GENERATED_DIR)/ccf_cell_biomarkers_larynx.owl: check_asctb2ccf $(GENERATED_DIR)
# 	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
# 	$(call generate_ccf_cell_biomarkers_component,Larynx,)
# .PRECIOUS: $(GENERATED_DIR)/ccf_cell_biomarkers_larynx.owl

# ------------------------------------------------------------------
# Get the ASCT+B Data as annotations 
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_asctb_annotations_larynx.owl: check_asctb2ccf $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,Larynx,)
.PRECIOUS: $(GENERATED_DIR)/ccf_asctb_annotations_larynx.owl

# ------------------------------------------------------------------
# Get as needed AS terms from Uberon Ontology
# ------------------------------------------------------------------
define private_extract_uberon_terms
	if [ $(EXT) = true ]; then $(ROBOT) query --input $(1) \
				--query queries/get_uberon_entities.sparql /tmp/entity_set_1.csv && \
		sed -i '1d' /tmp/entity_set_1.csv && \
		$(ROBOT) extract --method MIREOT \
				--input $(2) \
				--upper-term "http://purl.obolibrary.org/obo/UBERON_0001062" \
				--lower-terms /tmp/entity_set_1.csv \
				--intermediates $(INTERMEDIATES_OPT) \
			annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) \
				--output $@.tmp.owl && \
		mv $@.tmp.owl $@ && \
		rm /tmp/entity_set_*.csv; fi
endef

$(EXTRACTS_DIR)/uberon_larynx.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_larynx.owl \
		$(MIRRORDIR)/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call private_extract_uberon_terms,$(word 2,$^),$(word 3,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_larynx.owl

# ------------------------------------------------------------------
# Get as needed AS terms from FMA Ontology
# ------------------------------------------------------------------
# $(EXTRACTS_DIR)/fma_larynx.owl: $(EXTRACTS_DIR) \
# 		$(GENERATED_DIR)/ccf_asctb_annotations_larynx.owl \
# 		$(GENERATED_DIR)/ccf_cell_biomarkers_larynx.owl \
# 		$(GENERATED_DIR)/ccf_validation_larynx.owl \
# 		$(GENERATED_DIR)/ccf_validation_extended_larynx.owl \
# 		$(MIRRORDIR)/fma.owl
# 	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
# 	$(call extract_fma_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^))
# .PRECIOUS: $(EXTRACTS_DIR)/fma_larynx.owl

# ------------------------------------------------------------------
# Get as needed CT terms from Cell Ontology
# ------------------------------------------------------------------
# $(EXTRACTS_DIR)/cl_larynx.owl: $(EXTRACTS_DIR) \
# 		$(GENERATED_DIR)/ccf_asctb_annotations_larynx.owl \
# 		$(GENERATED_DIR)/ccf_cell_biomarkers_larynx.owl \
# 		$(GENERATED_DIR)/ccf_validation_larynx.owl \
# 		$(GENERATED_DIR)/ccf_validation_extended_larynx.owl \
# 		$(MIRRORDIR)/cl.owl
# 	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
# 	$(call extract_cl_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^))
# .PRECIOUS: $(EXTRACTS_DIR)/cl_larynx.owl

# ------------------------------------------------------------------
# Get as needed CT terms from LMHA Ontology
# ------------------------------------------------------------------
# $(EXTRACTS_DIR)/lmha_larynx.owl: $(EXTRACTS_DIR) \
# 		$(GENERATED_DIR)/ccf_asctb_annotations_larynx.owl \
# 		$(GENERATED_DIR)/ccf_cell_biomarkers_larynx.owl \
# 		$(GENERATED_DIR)/ccf_validation_larynx.owl \
# 		$(GENERATED_DIR)/ccf_validation_extended_larynx.owl \
# 		$(MIRRORDIR)/lmha.owl
# 	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
# 	$(call extract_lmha_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^))
# .PRECIOUS: $(EXTRACTS_DIR)/lmha_larynx.owl

# ------------------------------------------------------------------
# Get as needed B terms from HGNC
# ------------------------------------------------------------------
# $(EXTRACTS_DIR)/hgnc_larynx.owl: $(EXTRACTS_DIR) \
# 		$(GENERATED_DIR)/ccf_asctb_annotations_larynx.owl \
# 		$(GENERATED_DIR)/ccf_cell_biomarkers_larynx.owl \
# 		$(GENERATED_DIR)/ccf_validation_larynx.owl \
# 		$(GENERATED_DIR)/ccf_validation_extended_larynx.owl \
# 		$(MIRRORDIR)/hgnc.owl
# 	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
# 	$(call extract_hgnc_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^))
# .PRECIOUS: $(EXTRACTS_DIR)/hgnc_larynx.owl

# ------------------------------------------------------------------
# Build the ASCT+B table as an OWL ontology
# ------------------------------------------------------------------
define private_make_asctb_component
	if [ $(COMP) = true ]; then $(ROBOT) merge --input $(1) \
			--input $(3) \
		annotate --annotation-file $(2) \
			--ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) \
			--output $@.tmp.owl && \
		mv -f $@.tmp.owl $@; fi
endef

$(COMPONENTSDIR)/asctb_larynx.owl: $(COMPONENTSDIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_larynx.owl \
		$(ANNOTATIONS_DIR)/asctb_default.ttl \
		$(EXTRACTS_DIR)/uberon_larynx.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call private_make_asctb_component,$(word 2,$^),$(word 3,$^),$(word 4,$^))
.PRECIOUS: $(COMPONENTSDIR)/asctb_larynx.owl
