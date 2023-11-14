# ------------------------------------------------------------------
# Get the CCF Validation Tool Output
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_validation_extended_anatomical_systems.owl: | $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call download_ccf_validation_extended_owl,Anatomical_Systems)
.PRECIOUS: $(GENERATED_DIR)/ccf_validation_extended_anatomical_systems.owl

# ------------------------------------------------------------------
# Get the CT+B Cell-Type Markers
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_cell_biomarkers_anatomical_systems.owl: check_asctb2ccf $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,AnatomicalSystems,https://docs.google.com/spreadsheets/d/1oB3m_IOMEcDsdQoDicXd9KXXz7oytIPIPiu9lq88quU/edit#gid=2028977062)
.PRECIOUS: $(GENERATED_DIR)/ccf_cell_biomarkers_anatomical_systems.owl

# ------------------------------------------------------------------
# Get the ASCT+B Data as annotations 
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_asctb_annotations_anatomical_systems.owl: check_asctb2ccf $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,AnatomicalSystems,https://docs.google.com/spreadsheets/d/1oB3m_IOMEcDsdQoDicXd9KXXz7oytIPIPiu9lq88quU/edit#gid=2028977062)
.PRECIOUS: $(GENERATED_DIR)/ccf_asctb_annotations_anatomical_systems.owl

# ------------------------------------------------------------------
# Get as needed AS terms from Uberon Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/uberon_anatomical_systems.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_anatomical_systems.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_anatomical_systems.owl \
		$(GENERATED_DIR)/ccf_validation_extended_anatomical_systems.owl \
		$(MIRRORDIR)/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_uberon_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_anatomical_systems.owl

# ------------------------------------------------------------------
# Get as needed AS terms from FMA Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/fma_anatomical_systems.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_anatomical_systems.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_anatomical_systems.owl \
		$(GENERATED_DIR)/ccf_validation_extended_anatomical_systems.owl \
		$(MIRRORDIR)/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_fma_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/fma_anatomical_systems.owl

# ------------------------------------------------------------------
# Get as needed CT terms from Cell Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/cl_anatomical_systems.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_anatomical_systems.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_anatomical_systems.owl \
		$(GENERATED_DIR)/ccf_validation_extended_anatomical_systems.owl \
		$(MIRRORDIR)/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_cl_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_anatomical_systems.owl

# ------------------------------------------------------------------
# Get as needed CT terms from LMHA Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/lmha_anatomical_systems.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_anatomical_systems.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_anatomical_systems.owl \
		$(GENERATED_DIR)/ccf_validation_extended_anatomical_systems.owl \
		$(MIRRORDIR)/lmha.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_lmha_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/lmha_anatomical_systems.owl

# ------------------------------------------------------------------
# Get as needed B terms from HGNC
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/hgnc_anatomical_systems.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_anatomical_systems.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_anatomical_systems.owl \
		$(GENERATED_DIR)/ccf_validation_extended_anatomical_systems.owl \
		$(MIRRORDIR)/hgnc.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_hgnc_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/hgnc_anatomical_systems.owl

# ------------------------------------------------------------------
# Build the ASCT+B table as an OWL ontology
# ------------------------------------------------------------------
$(COMPONENTSDIR)/asctb_anatomical_systems.owl: $(COMPONENTSDIR) \
		$(GENERATED_DIR)/ccf_validation_extended_anatomical_systems.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_anatomical_systems.owl \
		$(GENERATED_DIR)/ccf_asctb_annotations_anatomical_systems.owl \
		$(ANNOTATIONS_DIR)/asctb_default.ttl \
		$(EXTRACTS_DIR)/uberon_anatomical_systems.owl \
		$(EXTRACTS_DIR)/fma_anatomical_systems.owl \
		$(EXTRACTS_DIR)/cl_anatomical_systems.owl \
		$(EXTRACTS_DIR)/lmha_anatomical_systems.owl \
		$(EXTRACTS_DIR)/hgnc_anatomical_systems.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^),$(word 7,$^),$(word 8,$^),$(word 9,$^),$(word 10,$^))
.PRECIOUS: $(COMPONENTSDIR)/asctb_anatomical_systems.owl