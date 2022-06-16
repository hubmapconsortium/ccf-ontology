# ------------------------------------------------------------------
# Get the AS Partonomy
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_partonomy_peripheral_nervous_system.owl: | $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call download_ccf_partonomy_component,Peripheral_nervous_system)
.PRECIOUS: $(GENERATED_DIR)/ccf_partonomy_peripheral_nervous_system.owl

# ------------------------------------------------------------------
# Get the CT+B Cell-Type Markers
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_cell_biomarkers_peripheral_nervous_system.owl: check_asctb2ccf $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,PeripheralNervousSystem,https://docs.google.com/spreadsheets/d/1KifiEDn3PpJ8pjz9_ka4TWkT085wLIzIQP5NKSvb2Ac/edit#gid=714133140)
.PRECIOUS: $(GENERATED_DIR)/ccf_cell_biomarkers_peripheral_nervous_system.owl

# ------------------------------------------------------------------
# Get the ASCT+B Data as annotations 
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_asctb_annotations_peripheral_nervous_system.owl: check_asctb2ccf $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,PeripheralNervousSystem,https://docs.google.com/spreadsheets/d/1KifiEDn3PpJ8pjz9_ka4TWkT085wLIzIQP5NKSvb2Ac/edit#gid=714133140)
.PRECIOUS: $(GENERATED_DIR)/ccf_asctb_annotations_peripheral_nervous_system.owl

# ------------------------------------------------------------------
# Get as needed AS terms from Uberon Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/uberon_peripheral_nervous_system.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_peripheral_nervous_system.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_peripheral_nervous_system.owl \
		$(GENERATED_DIR)/ccf_partonomy_peripheral_nervous_system.owl \
		$(MIRRORDIR)/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_uberon_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_peripheral_nervous_system.owl

# ------------------------------------------------------------------
# Get as needed AS terms from FMA Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/fma_peripheral_nervous_system.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_peripheral_nervous_system.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_peripheral_nervous_system.owl \
		$(GENERATED_DIR)/ccf_partonomy_peripheral_nervous_system.owl \
		$(MIRRORDIR)/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_fma_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/fma_peripheral_nervous_system.owl

# ------------------------------------------------------------------
# Get as needed CT terms from Cell Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/cl_peripheral_nervous_system.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_peripheral_nervous_system.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_peripheral_nervous_system.owl \
		$(GENERATED_DIR)/ccf_partonomy_peripheral_nervous_system.owl \
		$(MIRRORDIR)/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_cl_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_peripheral_nervous_system.owl

# ------------------------------------------------------------------
# Get as needed B terms from HGNC
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/hgnc_peripheral_nervous_system.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_peripheral_nervous_system.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_peripheral_nervous_system.owl \
		$(GENERATED_DIR)/ccf_partonomy_peripheral_nervous_system.owl \
		$(MIRRORDIR)/hgnc.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_hgnc_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/hgnc_peripheral_nervous_system.owl

# ------------------------------------------------------------------
# Build the ASCT+B table as an OWL ontology
# ------------------------------------------------------------------
$(COMPONENTSDIR)/asctb_peripheral_nervous_system.owl: $(COMPONENTSDIR) \
		$(GENERATED_DIR)/ccf_partonomy_peripheral_nervous_system.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_peripheral_nervous_system.owl \
		$(GENERATED_DIR)/ccf_asctb_annotations_peripheral_nervous_system.owl \
		$(ANNOTATIONS_DIR)/asctb_peripheral_nervous_system.ttl \
		$(EXTRACTS_DIR)/uberon_peripheral_nervous_system.owl \
		$(EXTRACTS_DIR)/fma_peripheral_nervous_system.owl \
		$(EXTRACTS_DIR)/cl_peripheral_nervous_system.owl \
		$(EXTRACTS_DIR)/hgnc_peripheral_nervous_system.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^),$(word 7,$^),$(word 8,$^),$(word 9,$^))
.PRECIOUS: $(COMPONENTSDIR)/asctb_peripheral_nervous_system.owl
