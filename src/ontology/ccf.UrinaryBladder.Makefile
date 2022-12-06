# ------------------------------------------------------------------
# Get the CCF Validation Tool Output
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_validation_urinary_bladder.owl: | $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call download_ccf_validation_owl,Urinary_bladder)
.PRECIOUS: $(GENERATED_DIR)/ccf_validation_urinary_bladder.owl

$(GENERATED_DIR)/ccf_validation_extended_urinary_bladder.owl: | $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call download_ccf_validation_extended_owl,Urinary_bladder)
.PRECIOUS: $(GENERATED_DIR)/ccf_validation_extended_urinary_bladder.owl

# ------------------------------------------------------------------
# Get the CT+B Cell-Type Markers
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_cell_biomarkers_urinary_bladder.owl: check_asctb2ccf $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,UrinaryBladder,https://docs.google.com/spreadsheets/d/1ohOG5jMf9d9eqjbVK6_u3CvgfG3wcLfs_pxB2838wOo/edit#gid=1342577957)
.PRECIOUS: $(GENERATED_DIR)/ccf_cell_biomarkers_urinary_bladder.owl

# ------------------------------------------------------------------
# Get the ASCT+B Data as annotations 
# ------------------------------------------------------------------
$(GENERATED_DIR)/ccf_asctb_annotations_urinary_bladder.owl: check_asctb2ccf $(GENERATED_DIR)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,UrinaryBladder,https://docs.google.com/spreadsheets/d/1ohOG5jMf9d9eqjbVK6_u3CvgfG3wcLfs_pxB2838wOo/edit#gid=1342577957)
.PRECIOUS: $(GENERATED_DIR)/ccf_asctb_annotations_urinary_bladder.owl

# ------------------------------------------------------------------
# Get as needed AS terms from Uberon Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/uberon_urinary_bladder.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_urinary_bladder.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_urinary_bladder.owl \
		$(GENERATED_DIR)/ccf_validation_urinary_bladder.owl \
		$(GENERATED_DIR)/ccf_validation_extended_urinary_bladder.owl \
		$(MIRRORDIR)/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_uberon_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_urinary_bladder.owl

# ------------------------------------------------------------------
# Get as needed AS terms from FMA Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/fma_urinary_bladder.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_urinary_bladder.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_urinary_bladder.owl \
		$(GENERATED_DIR)/ccf_validation_urinary_bladder.owl \
		$(GENERATED_DIR)/ccf_validation_extended_urinary_bladder.owl \
		$(MIRRORDIR)/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_fma_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^))
.PRECIOUS: $(EXTRACTS_DIR)/fma_urinary_bladder.owl

# ------------------------------------------------------------------
# Get as needed CT terms from Cell Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/cl_urinary_bladder.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_urinary_bladder.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_urinary_bladder.owl \
		$(GENERATED_DIR)/ccf_validation_urinary_bladder.owl \
		$(GENERATED_DIR)/ccf_validation_extended_urinary_bladder.owl \
		$(MIRRORDIR)/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_cl_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_urinary_bladder.owl

# ------------------------------------------------------------------
# Get as needed CT terms from LMHA Ontology
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/lmha_urinary_bladder.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_urinary_bladder.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_urinary_bladder.owl \
		$(GENERATED_DIR)/ccf_validation_urinary_bladder.owl \
		$(GENERATED_DIR)/ccf_validation_extended_urinary_bladder.owl \
		$(MIRRORDIR)/lmha.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_lmha_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^))
.PRECIOUS: $(EXTRACTS_DIR)/lmha_urinary_bladder.owl

# ------------------------------------------------------------------
# Get as needed B terms from HGNC
# ------------------------------------------------------------------
$(EXTRACTS_DIR)/hgnc_urinary_bladder.owl: $(EXTRACTS_DIR) \
		$(GENERATED_DIR)/ccf_asctb_annotations_urinary_bladder.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_urinary_bladder.owl \
		$(GENERATED_DIR)/ccf_validation_urinary_bladder.owl \
		$(GENERATED_DIR)/ccf_validation_extended_urinary_bladder.owl \
		$(MIRRORDIR)/hgnc.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Extracting $@)
	$(call extract_hgnc_terms,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^))
.PRECIOUS: $(EXTRACTS_DIR)/hgnc_urinary_bladder.owl

# ------------------------------------------------------------------
# Build the ASCT+B table as an OWL ontology
# ------------------------------------------------------------------
$(COMPONENTSDIR)/asctb_urinary_bladder.owl: $(COMPONENTSDIR) \
		$(GENERATED_DIR)/ccf_validation_urinary_bladder.owl \
		$(GENERATED_DIR)/ccf_cell_biomarkers_urinary_bladder.owl \
		$(GENERATED_DIR)/ccf_asctb_annotations_urinary_bladder.owl \
		$(ANNOTATIONS_DIR)/asctb_urinary_bladder.ttl \
		$(EXTRACTS_DIR)/uberon_urinary_bladder.owl \
		$(EXTRACTS_DIR)/fma_urinary_bladder.owl \
		$(EXTRACTS_DIR)/cl_urinary_bladder.owl \
		$(EXTRACTS_DIR)/lmha_urinary_bladder.owl \
		$(EXTRACTS_DIR)/hgnc_urinary_bladder.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 2,$^),$(word 3,$^),$(word 4,$^),$(word 5,$^),$(word 6,$^),$(word 7,$^),$(word 8,$^),$(word 9,$^),$(word 10,$^))
.PRECIOUS: $(COMPONENTSDIR)/asctb_urinary_bladder.owl
