## Customize Makefile settings for CCF ontology
## 
## If you need to customize your Makefile, make
## changes here rather than in the default Makefile

CCF = $(ONT)
CCF_BSO = $(ONT)-bso
CCF_SCO = $(ONT)-sco
CCF_SPO = $(ONT)-spo
CCF_SLIM = $(ONT)-slim

CCF_BSO_SRC = $(CCF_BSO)-edit.owl
CCF_SCO_SRC = $(CCF_SCO)-edit.owl
CCF_SPO_SRC = $(CCF_SPO)-edit.owl

GENERATED_DIR = generated
MODULES_DIR = modules
ANNOTATIONS_DIR = annotations
EXTRACTS_DIR = extracts
DATA_DIR = data
DATA_MIRROR_DIR = $(DATA_DIR)/mirror

COMP = true
EXT = true
DAT = true
DATMIR = true

$(GENERATED_DIR) $(MODULES_DIR) $(EXTRACTS_DIR) $(DATA_DIR) $(DATA_MIRROR_DIR):
	mkdir -p $@

# ----------------------------------------
# Importing Non-OBO ontologies
# ----------------------------------------

## ONTOLOGY: fma
.PHONY: mirror-fma
.PRECIOUS: $(MIRRORDIR)/fma.owl
mirror-fma: | $(TMPDIR)
	if [ $(MIR) = true ] && [ $(IMP) = true ]; then curl -L https://data.bioontology.org/ontologies/FMA/download\?apikey\=$(BIOPORTAL_API_KEY)\&download_format\=rdf --create-dirs -o $(MIRRORDIR)/fma.owl --retry 4 --max-time 200 && \
		$(ROBOT) convert -i $(MIRRORDIR)/fma.owl -o $@.tmp.owl && \
		mv $@.tmp.owl $(TMPDIR)/$@.owl; fi

$(MIRRORDIR)/fma.owl: mirror-fma | $(MIRRORDIR)
	if [ $(IMP) = true ] && [ $(MIR) = true ]; then if cmp -s $(TMPDIR)/mirror-fma.owl $@ ; then echo "Mirror identical, ignoring."; else echo "Mirrors different, updating." && cp $(TMPDIR)/mirror-fma.owl $@; fi; fi

## ONTOLOGY: hgnc
.PHONY: mirror-hgnc
.PRECIOUS: $(MIRRORDIR)/hgnc.owl
mirror-hgnc: | $(TMPDIR)
	if [ $(MIR) = true ] && [ $(IMP) = true ]; then curl -L https://github.com/musen-lab/hgnc2owl/raw/main/hgnc.owl.gz --create-dirs -o $(MIRRORDIR)/hgnc.owl.gz --retry 4 --max-time 200 && \
		gunzip -f $(MIRRORDIR)/hgnc.owl.gz && \
		$(ROBOT) convert -i $(MIRRORDIR)/hgnc.owl -o $@.tmp.owl && \
		mv $@.tmp.owl $(TMPDIR)/$@.owl; fi

$(MIRRORDIR)/hgnc.owl: mirror-hgnc | $(MIRRORDIR)
	if [ $(IMP) = true ] && [ $(MIR) = true ]; then if cmp -s $(TMPDIR)/mirror-hgnc.owl $@ ; then echo "Mirror identical, ignoring."; else echo "Mirrors different, updating." && cp $(TMPDIR)/mirror-hgnc.owl $@; fi; fi

# ----------------------------------------
# ASCT+B Module
# ---------------------------------------- 

include ccf.Asctb.Makefile

# ----------------------------------------
# Spatial and Specimen Data Module
# ----------------------------------------

DATA = \
	reference_spatial_entities \
	specimen_spatial_entities \
	specimen_dataset
DATA_FILES = $(patsubst %, $(DATA_DIR)/%.owl, $(DATA))

DATAMIRRORS = \
	reference-spatial-entities \
	generated-reference-spatial-entities \
	hubmap-datasets \
	kpmp-datasets \
	sparc-datasets \
	gtex-datasets
DATAMIRROR_FILES = $(patsubst %, $(DATA_MIRROR_DIR)/%.jsonld, $(DATAMIRRORS))

include ccf.Specimen.Makefile
include ccf.Spatial.Makefile

# ----------------------------------------
# THE 'MAKE' COMMANDS
# ----------------------------------------

# ----------------------------------------
# Prepare the ontology components
# ----------------------------------------

.PHONY: prepare_ccf_bso
prepare_ccf_bso: $(ASCTB_FILES)

.PHONY: prepare_ccf_sco
prepare_ccf_sco: $(DATA_DIR)/specimen_dataset.owl

.PHONY: prepare_ccf_spo
prepare_ccf_spo: $(DATA_DIR)/reference_spatial_entities.owl $(DATA_DIR)/specimen_spatial_entities.owl

.PHONY: prepare_all
prepare_all: $(ASCTB_FILES) $(DATA_FILES)

# ----------------------------------------
# Create the releases
# ----------------------------------------

CCF_ARTEFACTS = $(CCF_BSO) $(CCF_SCO) $(CCF_SPO) $(CCF) $(CCF_SLIM)
RELEASED_FILES = $(patsubst %, %.owl, $(CCF_ARTEFACTS))

.PHONY: release_ccf_bso
release_ccf_bso: $(CCF_BSO).owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating a release for the CCF Biological Structure (CCF-BSO) ontology)
	mv $^ $(RELEASEDIR)

.PHONY: release_ccf_sco
release_ccf_sco: $(CCF_SCO).owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating a release for the CCF Specimen (CCF-SCO) ontology)
	mv $^ $(RELEASEDIR)

.PHONY: release_ccf_spo
release_ccf_spo: $(CCF_SPO).owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating a release for the CCF Spatial (CCF-SPO) ontology)
	mv $^ $(RELEASEDIR)

.PHONY: release_only_ccf
release_only_ccf: $(CCF).owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating a release for the CCF ontology only)
	mv $^ $(RELEASEDIR)

.PHONY: release_ccf_slim
release_ccf_slim: $(CCF_SLIM).owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating a release for the CCF ontology (slim version)))
	mv $^ $(RELEASEDIR)

.PHONY: release_all
release_all: $(RELEASED_FILES)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating a release for the CCF ontology, including all its modules)
	mv $^ $(RELEASEDIR)


# ----------------------------------------
# Build the ontology
# ----------------------------------------

.PHONY: build_ccf_bso
build_ccf_bso: $(CCF_BSO).owl

$(CCF_BSO).owl: $(CCF_BSO_SRC)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating CCF Biological Structure (CCF-BSO) ontology)
	$(ROBOT) merge --input $< \
		reason --reasoner ELK --equivalent-classes-allowed asserted-only --exclude-tautologies structural \
		relax \
		reduce -r ELK \
		filter --exclude-terms excluded-terms.txt \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@
.PRECIOUS: $(CCF_BSO).owl

.PHONY: build_ccf_sco
build_ccf_sco: $(CCF_SCO).owl

$(CCF_SCO).owl: $(CCF_SCO_SRC)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating CCF Specimen (CCF-SCO) ontology)
	$(ROBOT) merge --input $< \
		reason --reasoner ELK --equivalent-classes-allowed asserted-only --exclude-tautologies structural \
		relax \
		reduce -r ELK \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@
.PRECIOUS: $(CCF_SCO).owl

.PHONY: build_ccf_spo
build_ccf_spo: $(CCF_SPO).owl

$(CCF_SPO).owl: $(CCF_SPO_SRC)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating CCF Spatial (CCF-SPO) ontology)
	$(ROBOT) merge --input $< \
		reason --reasoner ELK --equivalent-classes-allowed asserted-only --exclude-tautologies structural \
		relax \
		reduce -r ELK \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@
.PRECIOUS: $(CCF_SPO).owl

.PHONY: build_all
build_all: $(CCF_BSO).owl $(CCF_SCO).owl $(CCF_SPO).owl $(CCF).owl $(CCF_SLIM).owl

.PHONY: build_only_ccf
build_only_ccf: $(CCF).owl

$(CCF).owl: $(CCF_BSO).owl $(CCF_SPO).owl $(CCF_SCO).owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: overriding default ODK $(ONT).owl command)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating CCF ontology)
	$(ROBOT) merge --input $(word 1,$^) --input $(word 2,$^) --input $(word 3,$^) \
		reason --reasoner ELK \
			--equivalent-classes-allowed asserted-only \
			--exclude-tautologies structural \
		relax \
		reduce -r ELK \
		annotate --remove-annotations \
			--prefix "dc: http://purl.org/dc/elements/1.1/" \
			--prefix "dcterms: http://purl.org/dc/terms/" \
			--annotation dc:title "Common Coordinate Framework (CCF) Ontology" \
			--annotation dc:description "This ontology provides a view of the Uberon anatomy ontology and the Cell Ontology based on expert reviewed content provided by the HuBMaP project. Cell Ontology terms are linked to sets of expert-specified cell type markers, recorded using HGNC identifiers and metadata." \
			--link-annotation dcterms:license "https://creativecommons.org/licenses/by/4.0/" \
			--ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) \
			--output $@.tmp.owl && mv $@.tmp.owl $@
.PRECIOUS: $(CCF).owl

.PHONY: build_ccf_slim
build_ccf_slim: $(CCF_SLIM).owl

$(CCF_SLIM).owl: $(CCF_BSO).owl $(DATA_DIR)/reference_spatial_entities.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating CCF ontology (slim version))
	$(ROBOT) merge --input $(word 1,$^) --input $(word 2,$^) \
		remove --prefix "ccf: http://purl.org/ccf/" \
			--prefix "dc: http://purl.org/dc/elements/1.1/" \
			--prefix "dcterms: http://purl.org/dc/terms/" \
			--term-file ccf-terms.txt \
			--select complement \
			--select annotation-properties \
		reason --reasoner ELK \
			--equivalent-classes-allowed asserted-only \
			--exclude-tautologies structural \
		relax \
		reduce -r ELK \
		annotate --remove-annotations \
			--prefix "ccf: http://purl.org/ccf/" \
			--prefix "dc: http://purl.org/dc/elements/1.1/" \
			--prefix "dcterms: http://purl.org/dc/terms/" \
			--annotation dc:title "Common Coordinate Framework (CCF) Ontology (slim version)" \
			--link-annotation dcterms:license "https://creativecommons.org/licenses/by/4.0/" \
			--ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) \
			--output $@.tmp.owl && mv $@.tmp.owl $@
.PRECIOUS: $(CCF_SLIM).owl

# ----------------------------------------
# Clean up
# ----------------------------------------

.PHONY: clean_all
clean_all:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: cleaning up files)
	rm -rf components/* generated/* modules/* data/* extracts/* ccf.owl ccf-slim.owl ccf-bso.owl ccf-sco.owl ccf-spo.owl
