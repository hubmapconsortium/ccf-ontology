# ------------------------------------------------------------------
# Get the CCF Validation Tool Output
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_validation_extended_spinal_cord.owl: | $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call download_ccf_validation_extended_owl,Spinal_Cord)
.PRECIOUS: $(GENERATED_DIR)/ccf_validation_extended_spinal_cord.owl

# ------------------------------------------------------------------
# Get the CT+B Cell-Type Markers
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_cell_biomarkers_spinal_cord.owl: check_asctb2ccf $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,SpinalCord,https://docs.google.com/spreadsheets/d/1B8Yacpa0S_KuNqGGtKb83HTodKY_XGnIMy8tFCEIEdE/edit#gid=243784891)
.PRECIOUS: $(GENERATED_DIR)/ccf_cell_biomarkers_spinal_cord.owl

# ------------------------------------------------------------------
# Get the ASCT+B Data as annotations 
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_asctb_annotations_spinal_cord.owl: check_asctb2ccf $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,SpinalCord,https://docs.google.com/spreadsheets/d/1B8Yacpa0S_KuNqGGtKb83HTodKY_XGnIMy8tFCEIEdE/edit#gid=243784891)
.PRECIOUS: $(GENERATED_DIR)/ccf_asctb_annotations_spinal_cord.owl

# ------------------------------------------------------------------
# Get as needed AS terms from Uberon Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/uberon_spinal_cord.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_spinal_cord.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_spinal_cord.owl \
		$(GENERATED_DIR)/ccf_validation_extended_spinal_cord.owl \
		$(MIRRORDIR)/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_uberon_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_spinal_cord.owl

# ------------------------------------------------------------------
# Get as needed AS terms from FMA Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/fma_spinal_cord.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_spinal_cord.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_spinal_cord.owl \
		$(GENERATED_DIR)/ccf_validation_extended_spinal_cord.owl \
		$(MIRRORDIR)/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_fma_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/fma_spinal_cord.owl

# ------------------------------------------------------------------
# Get as needed CT terms from Cell Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/cl_spinal_cord.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_spinal_cord.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_spinal_cord.owl \
		$(GENERATED_DIR)/ccf_validation_extended_spinal_cord.owl \
		$(MIRRORDIR)/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_cl_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_spinal_cord.owl

# ------------------------------------------------------------------
# Get as needed CT terms from LMHA Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/lmha_spinal_cord.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_spinal_cord.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_spinal_cord.owl \
		$(GENERATED_DIR)/ccf_validation_extended_spinal_cord.owl \
		$(MIRRORDIR)/lmha.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_lmha_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/lmha_spinal_cord.owl

# ------------------------------------------------------------------
# Get as needed B terms from HGNC
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/hgnc_spinal_cord.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_spinal_cord.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_spinal_cord.owl \
		$(GENERATED_DIR)/ccf_validation_extended_spinal_cord.owl \
		$(MIRRORDIR)/hgnc.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_hgnc_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/hgnc_spinal_cord.owl

# ------------------------------------------------------------------
# Build the ASCT+B table as an OWL ontology
# ------------------------------------------------------------------
$(COMPONENTSDIR)/asctb_spinal_cord.owl: $(COMPONENTSDIR) \
		$(GENERATED_DIR)/ccf_validation_extended_spinal_cord.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_spinal_cord.owl \
		$(GENERATED_DIR)/ccf_asctb_annotations_spinal_cord.owl \
		$(ANNOTATIONS_DIR)/asctb_spinal_cord.ttl \
		$(EXTRACTS_DIR)/uberon_spinal_cord.owl \
		$(EXTRACTS_DIR)/fma_spinal_cord.owl \
		$(EXTRACTS_DIR)/cl_spinal_cord.owl \
		$(EXTRACTS_DIR)/lmha_spinal_cord.owl \
		$(EXTRACTS_DIR)/hgnc_spinal_cord.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^),$(word 7,$^),$(word 8,$^),$(word 9,$^),$(word 10,$^))
.PRECIOUS: $(COMPONENTSDIR)/asctb_spinal_cord.owl
