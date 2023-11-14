# ------------------------------------------------------------------
# Get the CCF Validation Tool Output
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_validation_extended_skin.owl: | $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call download_ccf_validation_extended_owl,Skin)
.PRECIOUS: $(GENERATED_DIR)/ccf_validation_extended_skin.owl

# ------------------------------------------------------------------
# Get the CT+B Cell-Type Markers
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_cell_biomarkers_skin.owl: check_asctb2ccf $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,Skin,https://docs.google.com/spreadsheets/d/1q2tYQ_uNh5O_eLOMUZm64ncCUeJc8mrern3zkRX3Ppw/edit#gid=269383687)
.PRECIOUS: $(GENERATED_DIR)/ccf_cell_biomarkers_skin.owl

# ------------------------------------------------------------------
# Get the ASCT+B Data as annotations 
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_asctb_annotations_skin.owl: check_asctb2ccf $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,Skin,https://docs.google.com/spreadsheets/d/1q2tYQ_uNh5O_eLOMUZm64ncCUeJc8mrern3zkRX3Ppw/edit#gid=269383687)
.PRECIOUS: $(GENERATED_DIR)/ccf_asctb_annotations_skin.owl

# ------------------------------------------------------------------
# Get as needed AS terms from Uberon Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/uberon_skin.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_skin.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_skin.owl \
		$(GENERATED_DIR)/ccf_validation_extended_skin.owl \
		$(MIRRORDIR)/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_uberon_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_skin.owl

# ------------------------------------------------------------------
# Get as needed AS terms from FMA Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/fma_skin.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_skin.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_skin.owl \
		$(GENERATED_DIR)/ccf_validation_extended_skin.owl \
		$(MIRRORDIR)/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_fma_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/fma_skin.owl

# ------------------------------------------------------------------
# Get as needed CT terms from Cell Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/cl_skin.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_skin.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_skin.owl \
		$(GENERATED_DIR)/ccf_validation_extended_skin.owl \
		$(MIRRORDIR)/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_cl_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_skin.owl

# ------------------------------------------------------------------
# Get as needed CT terms from LMHA Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/lmha_skin.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_skin.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_skin.owl \
		$(GENERATED_DIR)/ccf_validation_extended_skin.owl \
		$(MIRRORDIR)/lmha.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_lmha_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/lmha_skin.owl

# ------------------------------------------------------------------
# Get as needed B terms from HGNC
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/hgnc_skin.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_skin.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_skin.owl \
		$(GENERATED_DIR)/ccf_validation_extended_skin.owl \
		$(MIRRORDIR)/hgnc.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_hgnc_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/hgnc_skin.owl

# ------------------------------------------------------------------
# Build the ASCT+B table as an OWL ontology
# ------------------------------------------------------------------
$(COMPONENTSDIR)/asctb_skin.owl: $(COMPONENTSDIR) \
		$(GENERATED_DIR)/ccf_validation_extended_skin.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_skin.owl \
		$(GENERATED_DIR)/ccf_asctb_annotations_skin.owl \
		$(ANNOTATIONS_DIR)/asctb_skin.ttl \
		$(EXTRACTS_DIR)/uberon_skin.owl \
		$(EXTRACTS_DIR)/fma_skin.owl \
		$(EXTRACTS_DIR)/cl_skin.owl \
		$(EXTRACTS_DIR)/lmha_skin.owl \
		$(EXTRACTS_DIR)/hgnc_skin.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^),$(word 7,$^),$(word 8,$^),$(word 9,$^),$(word 10,$^))
.PRECIOUS: $(COMPONENTSDIR)/asctb_skin.owl
