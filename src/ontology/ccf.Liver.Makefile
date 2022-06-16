# ------------------------------------------------------------------
# Get the AS Partonomy
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_partonomy_liver.owl: | $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call download_ccf_partonomy_component,Liver)
.PRECIOUS: $(GENERATED_DIR)/ccf_partonomy_liver.owl

# ------------------------------------------------------------------
# Get the CT+B Cell-Type Markers
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_cell_biomarkers_liver.owl: check_asctb2ccf $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,https://docs.google.com/spreadsheets/d/1F8ZXt1naE1pJFjfsAd6wK7x22D3qRW5O0E2d9gUKAik/edit#gid=1694828397)
.PRECIOUS: $(GENERATED_DIR)/ccf_cell_biomarkers_liver.owl

# ------------------------------------------------------------------
# Get the ASCT+B Data as annotations 
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_asctb_annotations_liver.owl: check_asctb2ccf $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,https://docs.google.com/spreadsheets/d/1F8ZXt1naE1pJFjfsAd6wK7x22D3qRW5O0E2d9gUKAik/edit#gid=1694828397)
.PRECIOUS: $(GENERATED_DIR)/ccf_asctb_annotations_liver.owl

# ------------------------------------------------------------------
# Get as needed AS terms from Uberon Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/uberon_liver.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_liver.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_liver.owl \
		$(GENERATED_DIR)/ccf_partonomy_liver.owl \
		$(MIRRORDIR)/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_uberon_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_liver.owl

# ------------------------------------------------------------------
# Get as needed AS terms from FMA Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/fma_liver.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_liver.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_liver.owl \
		$(GENERATED_DIR)/ccf_partonomy_liver.owl \
		$(MIRRORDIR)/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_fma_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/fma_liver.owl

# ------------------------------------------------------------------
# Get as needed CT terms from Cell Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/cl_liver.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_liver.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_liver.owl \
		$(GENERATED_DIR)/ccf_partonomy_liver.owl \
		$(MIRRORDIR)/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_cl_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_liver.owl

# ------------------------------------------------------------------
# Get as needed B terms from HGNC
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/hgnc_liver.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_liver.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_liver.owl \
		$(GENERATED_DIR)/ccf_partonomy_liver.owl \
		$(MIRRORDIR)/hgnc.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_hgnc_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^))
.PRECIOUS: $(EXTRACTS_DIR)/hgnc_liver.owl

# ------------------------------------------------------------------
# Build the ASCT+B table as an OWL ontology
# ------------------------------------------------------------------
$(COMPONENTSDIR)/asctb_liver.owl: $(COMPONENTSDIR) \
		$(GENERATED_DIR)/ccf_partonomy_liver.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_liver.owl \
		$(GENERATED_DIR)/ccf_asctb_annotations_liver.owl \
		$(ANNOTATIONS_DIR)/asctb_liver.ttl \
		$(EXTRACTS_DIR)/uberon_liver.owl \
		$(EXTRACTS_DIR)/fma_liver.owl \
		$(EXTRACTS_DIR)/cl_liver.owl \
		$(EXTRACTS_DIR)/hgnc_liver.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^),$(word 7,$^),$(word 8,$^),$(word 9,$^))
.PRECIOUS: $(COMPONENTSDIR)/asctb_liver.owl
