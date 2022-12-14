# ------------------------------------------------------------------
# Get the CCF Validation Tool Output
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_validation_large_intestine.owl: | $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call download_ccf_validation_owl,Large_intestine)
.PRECIOUS: $(GENERATED_DIR)/ccf_validation_large_intestine.owl

$(GENERATED_DIR)/ccf_validation_extended_large_intestine.owl: | $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call download_ccf_validation_extended_owl,Large_intestine)
.PRECIOUS: $(GENERATED_DIR)/ccf_validation_extended_large_intestine.owl

# ------------------------------------------------------------------
# Get the CT+B Cell-Type Markers
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_cell_biomarkers_large_intestine.owl: check_asctb2ccf $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,LargeIntestine,https://docs.google.com/spreadsheets/d/1DgN9i72VFDmGwynStGbhkpHfas_RA9ccIrDgI77ULJA/edit#gid=2043181688)
.PRECIOUS: $(GENERATED_DIR)/ccf_cell_biomarkers_large_intestine.owl

# ------------------------------------------------------------------
# Get the ASCT+B Data as annotations 
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_asctb_annotations_large_intestine.owl: check_asctb2ccf $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,LargeIntestine,https://docs.google.com/spreadsheets/d/1DgN9i72VFDmGwynStGbhkpHfas_RA9ccIrDgI77ULJA/edit#gid=2043181688)
.PRECIOUS: $(GENERATED_DIR)/ccf_asctb_annotations_large_intestine.owl

# ------------------------------------------------------------------
# Get as needed AS terms from Uberon Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/uberon_large_intestine.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_large_intestine.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_large_intestine.owl \
		$(GENERATED_DIR)/ccf_validation_large_intestine.owl \
		$(GENERATED_DIR)/ccf_validation_extended_large_intestine.owl \
		$(MIRRORDIR)/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_uberon_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_large_intestine.owl

# ------------------------------------------------------------------
# Get as needed AS terms from FMA Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/fma_large_intestine.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_large_intestine.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_large_intestine.owl \
		$(GENERATED_DIR)/ccf_validation_large_intestine.owl \
		$(GENERATED_DIR)/ccf_validation_extended_large_intestine.owl \
		$(MIRRORDIR)/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_fma_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^))
.PRECIOUS: $(EXTRACTS_DIR)/fma_large_intestine.owl

# ------------------------------------------------------------------
# Get as needed CT terms from Cell Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/cl_large_intestine.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_large_intestine.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_large_intestine.owl \
		$(GENERATED_DIR)/ccf_validation_large_intestine.owl \
		$(GENERATED_DIR)/ccf_validation_extended_large_intestine.owl \
		$(MIRRORDIR)/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_cl_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_large_intestine.owl

# ------------------------------------------------------------------
# Get as needed CT terms from LMHA Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/lmha_large_intestine.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_large_intestine.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_large_intestine.owl \
		$(GENERATED_DIR)/ccf_validation_large_intestine.owl \
		$(GENERATED_DIR)/ccf_validation_extended_large_intestine.owl \
		$(MIRRORDIR)/lmha.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_lmha_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^))
.PRECIOUS: $(EXTRACTS_DIR)/lmha_large_intestine.owl

# ------------------------------------------------------------------
# Get as needed B terms from HGNC
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/hgnc_large_intestine.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_large_intestine.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_large_intestine.owl \
		$(GENERATED_DIR)/ccf_validation_large_intestine.owl \
		$(GENERATED_DIR)/ccf_validation_extended_large_intestine.owl \
		$(MIRRORDIR)/hgnc.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_hgnc_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^))
.PRECIOUS: $(EXTRACTS_DIR)/hgnc_large_intestine.owl

# ------------------------------------------------------------------
# Build the ASCT+B table as an OWL ontology
# ------------------------------------------------------------------
$(COMPONENTSDIR)/asctb_large_intestine.owl: $(COMPONENTSDIR) \
		$(GENERATED_DIR)/ccf_validation_large_intestine.owl \
		$(GENERATED_DIR)/ccf_validation_extended_large_intestine.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_large_intestine.owl \
		$(GENERATED_DIR)/ccf_asctb_annotations_large_intestine.owl \
		$(ANNOTATIONS_DIR)/asctb_large_intestine.ttl \
		$(EXTRACTS_DIR)/uberon_large_intestine.owl \
		$(EXTRACTS_DIR)/fma_large_intestine.owl \
		$(EXTRACTS_DIR)/cl_large_intestine.owl \
		$(EXTRACTS_DIR)/lmha_large_intestine.owl \
		$(EXTRACTS_DIR)/hgnc_large_intestine.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^),$(word 7,$^),$(word 8,$^),$(word 9,$^),$(word 10,$^),$(word 11,$^))
.PRECIOUS: $(COMPONENTSDIR)/asctb_large_intestine.owl
