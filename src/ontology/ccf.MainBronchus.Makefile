# ------------------------------------------------------------------
# Get the CCF Validation Tool Output
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_validation_main_bronchus.owl: | $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call download_ccf_validation_owl,Main_Bronchus)
.PRECIOUS: $(GENERATED_DIR)/ccf_validation_main_bronchus.owl

$(GENERATED_DIR)/ccf_validation_extended_main_bronchus.owl: | $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call download_ccf_validation_extended_owl,Main_Bronchus)
.PRECIOUS: $(GENERATED_DIR)/ccf_validation_extended_main_bronchus.owl

# ------------------------------------------------------------------
# Get the CT+B Cell-Type Markers
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_cell_biomarkers_main_bronchus.owl: check_asctb2ccf $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,MainBronchus,https://docs.google.com/spreadsheets/d/1VstIfAHSehrY5MNeTlNtRlOHtbQN8psru5rl5vglPxA/edit#gid=0)
.PRECIOUS: $(GENERATED_DIR)/ccf_cell_biomarkers_main_bronchus.owl

# ------------------------------------------------------------------
# Get the ASCT+B Data as annotations 
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_asctb_annotations_main_bronchus.owl: check_asctb2ccf $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,MainBronchus,https://docs.google.com/spreadsheets/d/1VstIfAHSehrY5MNeTlNtRlOHtbQN8psru5rl5vglPxA/edit#gid=0)
.PRECIOUS: $(GENERATED_DIR)/ccf_asctb_annotations_main_bronchus.owl

# ------------------------------------------------------------------
# Get as needed AS terms from Uberon Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/uberon_main_bronchus.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_main_bronchus.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_main_bronchus.owl \
		$(GENERATED_DIR)/ccf_validation_main_bronchus.owl \
		$(GENERATED_DIR)/ccf_validation_extended_main_bronchus.owl \
		$(MIRRORDIR)/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_uberon_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_main_bronchus.owl

# ------------------------------------------------------------------
# Get as needed AS terms from FMA Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/fma_main_bronchus.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_main_bronchus.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_main_bronchus.owl \
		$(GENERATED_DIR)/ccf_validation_main_bronchus.owl \
		$(GENERATED_DIR)/ccf_validation_extended_main_bronchus.owl \
		$(MIRRORDIR)/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_fma_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^))
.PRECIOUS: $(EXTRACTS_DIR)/fma_main_bronchus.owl

# ------------------------------------------------------------------
# Get as needed CT terms from Cell Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/cl_main_bronchus.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_main_bronchus.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_main_bronchus.owl \
		$(GENERATED_DIR)/ccf_validation_main_bronchus.owl \
		$(GENERATED_DIR)/ccf_validation_extended_main_bronchus.owl \
		$(MIRRORDIR)/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_cl_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_main_bronchus.owl

# ------------------------------------------------------------------
# Get as needed CT terms from LMHA Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/lmha_main_bronchus.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_main_bronchus.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_main_bronchus.owl \
		$(GENERATED_DIR)/ccf_validation_main_bronchus.owl \
		$(GENERATED_DIR)/ccf_validation_extended_main_bronchus.owl \
		$(MIRRORDIR)/lmha.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_lmha_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^))
.PRECIOUS: $(EXTRACTS_DIR)/lmha_main_bronchus.owl

# ------------------------------------------------------------------
# Get as needed B terms from HGNC
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/hgnc_main_bronchus.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_main_bronchus.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_main_bronchus.owl \
		$(GENERATED_DIR)/ccf_validation_main_bronchus.owl \
		$(GENERATED_DIR)/ccf_validation_extended_main_bronchus.owl \
		$(MIRRORDIR)/hgnc.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_hgnc_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^))
.PRECIOUS: $(EXTRACTS_DIR)/hgnc_main_bronchus.owl

# ------------------------------------------------------------------
# Build the ASCT+B table as an OWL ontology
# ------------------------------------------------------------------
$(COMPONENTSDIR)/asctb_main_bronchus.owl: $(COMPONENTSDIR) \
		$(GENERATED_DIR)/ccf_validation_main_bronchus.owl \
		$(GENERATED_DIR)/ccf_validation_extended_main_bronchus.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_main_bronchus.owl \
		$(GENERATED_DIR)/ccf_asctb_annotations_main_bronchus.owl \
		$(ANNOTATIONS_DIR)/asctb_default.ttl \
		$(EXTRACTS_DIR)/uberon_main_bronchus.owl \
		$(EXTRACTS_DIR)/fma_main_bronchus.owl \
		$(EXTRACTS_DIR)/cl_main_bronchus.owl \
		$(EXTRACTS_DIR)/lmha_main_bronchus.owl \
		$(EXTRACTS_DIR)/hgnc_main_bronchus.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^),$(word 7,$^),$(word 8,$^),$(word 9,$^),$(word 10,$^),$(word 11,$^))
.PRECIOUS: $(COMPONENTSDIR)/asctb_main_bronchus.owl
