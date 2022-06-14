# ------------------------------------------------------------------
# Get the AS Partonomy
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_partonomy_lymph_node.owl: | $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call download_ccf_partonomy_component,Lymph_node)
.PRECIOUS: $(GENERATED_DIR)/ccf_partonomy_lymph_node.owl

# ------------------------------------------------------------------
# Get the CT+B Cell-Type Markers
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_cell_biomarkers_lymph_node.owl: check_asctb2ccf $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,https://docs.google.com/spreadsheets/d/1aK9gJ2_kMb2B8zrQgScDgxpEWAcCs7kl-gnQGwV3LHM/edit#gid=1223566381)
.PRECIOUS: $(GENERATED_DIR)/ccf_cell_biomarkers_lymph_node.owl

# ------------------------------------------------------------------
# Get the ASCT+B Data as annotations 
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_asctb_annotations_lymph_node.owl: check_asctb2ccf $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,https://docs.google.com/spreadsheets/d/1aK9gJ2_kMb2B8zrQgScDgxpEWAcCs7kl-gnQGwV3LHM/edit#gid=1223566381)
.PRECIOUS: $(GENERATED_DIR)/ccf_asctb_annotations_lymph_node.owl

# ------------------------------------------------------------------
# Get as needed AS terms from Uberon Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/uberon_lymph_node.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_lymph_node.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_lymph_node.owl \
		$(GENERATED_DIR)/ccf_partonomy_lymph_node.owl \
		$(MIRRORDIR)/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_uberon_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_lymph_node.owl

# ------------------------------------------------------------------
# Get as needed AS terms from FMA Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/fma_lymph_node.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_lymph_node.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_lymph_node.owl \
		$(GENERATED_DIR)/ccf_partonomy_lymph_node.owl \
		$(MIRRORDIR)/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_fma_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/fma_lymph_node.owl

# ------------------------------------------------------------------
# Get as needed CT terms from Cell Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/cl_lymph_node.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_lymph_node.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_lymph_node.owl \
		$(GENERATED_DIR)/ccf_partonomy_lymph_node.owl \
		$(MIRRORDIR)/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_cl_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_lymph_node.owl

# ------------------------------------------------------------------
# Get as needed B terms from HGNC
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/hgnc_lymph_node.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_lymph_node.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_lymph_node.owl \
		$(GENERATED_DIR)/ccf_partonomy_lymph_node.owl \
		$(MIRRORDIR)/hgnc.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_hgnc_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/hgnc_lymph_node.owl

# ------------------------------------------------------------------
# Build the ASCT+B table as an OWL ontology
# ------------------------------------------------------------------
$(COMPONENTSDIR)/asctb_lymph_node.owl: $(COMPONENTSDIR) \
		$(GENERATED_DIR)/ccf_partonomy_lymph_node.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_lymph_node.owl \
		$(GENERATED_DIR)/ccf_asctb_annotations_lymph_node.owl \
		$(ANNOTATIONS_DIR)/asctb_lymph_node.ttl \
		$(EXTRACTS_DIR)/uberon_lymph_node.owl \
		$(EXTRACTS_DIR)/fma_lymph_node.owl \
		$(EXTRACTS_DIR)/cl_lymph_node.owl \
		$(EXTRACTS_DIR)/hgnc_lymph_node.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^),$(word 7,$^),$(word 8,$^),$(word 9,$^))
.PRECIOUS: $(COMPONENTSDIR)/asctb_lymph_node.owl
