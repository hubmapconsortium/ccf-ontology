# ------------------------------------------------------------------
# Get the CCF Validation Tool Output
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_validation_extended_fallopian_tube.owl: | $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call download_ccf_validation_extended_owl,Fallopian_tube)
.PRECIOUS: $(GENERATED_DIR)/ccf_validation_extended_fallopian_tube.owl

# ------------------------------------------------------------------
# Get the CT+B Cell-Type Markers
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_cell_biomarkers_fallopian_tube.owl: check_asctb2ccf $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,FallopianTube,https://docs.google.com/spreadsheets/d/16DHu7R9MC2B_fP7uRiDYcDIUvFs6SwHmZWgwpzuJwfI/edit#gid=991519552)
.PRECIOUS: $(GENERATED_DIR)/ccf_cell_biomarkers_fallopian_tube.owl

# ------------------------------------------------------------------
# Get the ASCT+B Data as annotations 
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_asctb_annotations_fallopian_tube.owl: check_asctb2ccf $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,FallopianTube,https://docs.google.com/spreadsheets/d/16DHu7R9MC2B_fP7uRiDYcDIUvFs6SwHmZWgwpzuJwfI/edit#gid=991519552)
.PRECIOUS: $(GENERATED_DIR)/ccf_asctb_annotations_fallopian_tube.owl

# ------------------------------------------------------------------
# Get as needed AS terms from Uberon Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/uberon_fallopian_tube.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_fallopian_tube.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_fallopian_tube.owl \
		$(GENERATED_DIR)/ccf_validation_extended_fallopian_tube.owl \
		$(MIRRORDIR)/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_uberon_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_fallopian_tube.owl

# ------------------------------------------------------------------
# Get as needed AS terms from FMA Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/fma_fallopian_tube.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_fallopian_tube.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_fallopian_tube.owl \
		$(GENERATED_DIR)/ccf_validation_extended_fallopian_tube.owl \
		$(MIRRORDIR)/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_fma_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/fma_fallopian_tube.owl

# ------------------------------------------------------------------
# Get as needed CT terms from Cell Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/cl_fallopian_tube.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_fallopian_tube.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_fallopian_tube.owl \
		$(GENERATED_DIR)/ccf_validation_extended_fallopian_tube.owl \
		$(MIRRORDIR)/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_cl_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_fallopian_tube.owl

# ------------------------------------------------------------------
# Get as needed CT terms from LMHA Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/lmha_fallopian_tube.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_fallopian_tube.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_fallopian_tube.owl \
		$(GENERATED_DIR)/ccf_validation_extended_fallopian_tube.owl \
		$(MIRRORDIR)/lmha.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_lmha_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/lmha_fallopian_tube.owl

# ------------------------------------------------------------------
# Get as needed B terms from HGNC
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/hgnc_fallopian_tube.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_fallopian_tube.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_fallopian_tube.owl \
		$(GENERATED_DIR)/ccf_validation_extended_fallopian_tube.owl \
		$(MIRRORDIR)/hgnc.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_hgnc_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/hgnc_fallopian_tube.owl

# ------------------------------------------------------------------
# Build the ASCT+B table as an OWL ontology
# ------------------------------------------------------------------
$(COMPONENTSDIR)/asctb_fallopian_tube.owl: $(COMPONENTSDIR) \
		$(GENERATED_DIR)/ccf_validation_extended_fallopian_tube.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_fallopian_tube.owl \
		$(GENERATED_DIR)/ccf_asctb_annotations_fallopian_tube.owl \
		$(ANNOTATIONS_DIR)/asctb_fallopian_tube.ttl \
		$(EXTRACTS_DIR)/uberon_fallopian_tube.owl \
		$(EXTRACTS_DIR)/fma_fallopian_tube.owl \
		$(EXTRACTS_DIR)/cl_fallopian_tube.owl \
		$(EXTRACTS_DIR)/lmha_fallopian_tube.owl \
		$(EXTRACTS_DIR)/hgnc_fallopian_tube.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^),$(word 7,$^),$(word 8,$^),$(word 9,$^),$(word 10,$^))
.PRECIOUS: $(COMPONENTSDIR)/asctb_fallopian_tube.owl
