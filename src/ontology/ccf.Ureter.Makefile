# ------------------------------------------------------------------
# Get the CCF Validation Tool Output
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_validation_ureter.owl: | $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call download_ccf_validation_owl,Ureter)
.PRECIOUS: $(GENERATED_DIR)/ccf_validation_ureter.owl

$(GENERATED_DIR)/ccf_validation_extended_ureter.owl: | $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call download_ccf_validation_extended_owl,Ureter)
.PRECIOUS: $(GENERATED_DIR)/ccf_validation_extended_ureter.owl

# ------------------------------------------------------------------
# Get the CT+B Cell-Type Markers
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_cell_biomarkers_ureter.owl: check_asctb2ccf $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,Ureter,https://docs.google.com/spreadsheets/d/1tK916JyG5ZSXW_cXfsyZnzXfjyoN-8B2GXLbYD6_vF0/edit#gid=1106564583)
.PRECIOUS: $(GENERATED_DIR)/ccf_cell_biomarkers_ureter.owl

# ------------------------------------------------------------------
# Get the ASCT+B Data as annotations 
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_asctb_annotations_ureter.owl: check_asctb2ccf $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,Ureter,https://docs.google.com/spreadsheets/d/1tK916JyG5ZSXW_cXfsyZnzXfjyoN-8B2GXLbYD6_vF0/edit#gid=1106564583)
.PRECIOUS: $(GENERATED_DIR)/ccf_asctb_annotations_ureter.owl

# ------------------------------------------------------------------
# Get as needed AS terms from Uberon Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/uberon_ureter.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_ureter.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_ureter.owl \
		$(GENERATED_DIR)/ccf_validation_ureter.owl \
		$(GENERATED_DIR)/ccf_validation_extended_ureter.owl \
		$(MIRRORDIR)/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_uberon_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_ureter.owl

# ------------------------------------------------------------------
# Get as needed AS terms from FMA Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/fma_ureter.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_ureter.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_ureter.owl \
		$(GENERATED_DIR)/ccf_validation_ureter.owl \
		$(GENERATED_DIR)/ccf_validation_extended_ureter.owl \
		$(MIRRORDIR)/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_fma_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^))
.PRECIOUS: $(EXTRACTS_DIR)/fma_ureter.owl

# ------------------------------------------------------------------
# Get as needed CT terms from Cell Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/cl_ureter.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_ureter.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_ureter.owl \
		$(GENERATED_DIR)/ccf_validation_ureter.owl \
		$(GENERATED_DIR)/ccf_validation_extended_ureter.owl \
		$(MIRRORDIR)/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_cl_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_ureter.owl

# ------------------------------------------------------------------
# Get as needed CT terms from LMHA Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/lmha_ureter.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_ureter.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_ureter.owl \
		$(GENERATED_DIR)/ccf_validation_ureter.owl \
		$(GENERATED_DIR)/ccf_validation_extended_ureter.owl \
		$(MIRRORDIR)/lmha.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_lmha_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^))
.PRECIOUS: $(EXTRACTS_DIR)/lmha_ureter.owl

# ------------------------------------------------------------------
# Get as needed B terms from HGNC
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/hgnc_ureter.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_ureter.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_ureter.owl \
		$(GENERATED_DIR)/ccf_validation_ureter.owl \
		$(GENERATED_DIR)/ccf_validation_extended_ureter.owl \
		$(MIRRORDIR)/hgnc.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_hgnc_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^))
.PRECIOUS: $(EXTRACTS_DIR)/hgnc_ureter.owl

# ------------------------------------------------------------------
# Build the ASCT+B table as an OWL ontology
# ------------------------------------------------------------------
$(COMPONENTSDIR)/asctb_ureter.owl: $(COMPONENTSDIR) \
		$(GENERATED_DIR)/ccf_validation_ureter.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_ureter.owl \
		$(GENERATED_DIR)/ccf_asctb_annotations_ureter.owl \
		$(ANNOTATIONS_DIR)/asctb_ureter.ttl \
		$(EXTRACTS_DIR)/uberon_ureter.owl \
		$(EXTRACTS_DIR)/fma_ureter.owl \
		$(EXTRACTS_DIR)/cl_ureter.owl \
		$(EXTRACTS_DIR)/lmha_ureter.owl \
		$(EXTRACTS_DIR)/hgnc_ureter.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^),$(word 7,$^),$(word 8,$^),$(word 9,$^),$(word 10,$^))
.PRECIOUS: $(COMPONENTSDIR)/asctb_ureter.owl
