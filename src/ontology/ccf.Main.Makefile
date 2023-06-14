## Customize Makefile settings for CCF ontology
## 
## If you need to customize your Makefile, make
## changes here rather than in the default Makefile

CCF = $(ONT)
CCF_BSO = $(ONT)-bso
CCF_SCO = $(ONT)-sco
CCF_SPO = $(ONT)-spo

CCF_BSO_SRC = $(CCF_BSO)-edit.owl
CCF_SCO_SRC = $(CCF_SCO)-edit.owl
CCF_SPO_SRC = $(CCF_SPO)-edit.owl

GENERATED_DIR = generated
MODULES_DIR = modules
ANNOTATIONS_DIR = annotations
EXTRACTS_DIR = extracts
INSTANCES_DIR = instances

COMP = true
EXT = true
INST = true

$(GENERATED_DIR) $(MODULES_DIR) $(EXTRACTS_DIR) $(INSTANCES_DIR):
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

## ONTOLOGY: lmha
.PHONY: mirror-lmha
.PRECIOUS: $(MIRRORDIR)/lmha.owl
mirror-lmha:
	if [ $(MIR) = true ] && [ $(IMP) = true ]; then curl -L https://www.lungmap.net/assets/Uploads/ontology/558488ae7f/LMHA_20190512_Cell.zip --create-dirs -o $(TMPDIR)/lmha.zip --retry 4 --max-time 200 && \
		unzip -o $(TMPDIR)/lmha.zip -d $(TMPDIR) && \
		mv $(TMPDIR)/LMHA_20190512_Cell.owl $(MIRRORDIR)/lmha.owl && \
		$(ROBOT) convert -i $(MIRRORDIR)/lmha.owl -o $@.tmp.owl && \
		mv $@.tmp.owl $(TMPDIR)/$@.owl; fi

$(MIRRORDIR)/lmha.owl: mirror-lmha | $(MIRRORDIR)
	if [ $(IMP) = true ] && [ $(MIR) = true ]; then if cmp -s $(TMPDIR)/mirror-lmha.owl $@ ; then echo "Mirror identical, ignoring."; else echo "Mirrors different, updating." && cp $(TMPDIR)/mirror-lmha.owl $@; fi; fi

# ----------------------------------------
# Spatial Module
# ----------------------------------------

include ccf.Spatial.Makefile
		
# ----------------------------------------
# ASCT+B Module
# ---------------------------------------- 

include ccf.Asctb.Makefile

# ----------------------------------------
# THE 'MAKE' COMMANDS
# ----------------------------------------

# ----------------------------------------
# Prepare the ontology components
# ----------------------------------------

.PHONY: prepare_all
prepare_all: $(ASCTB_FILES) $(SPATIAL_FILES)

# ----------------------------------------
# Create the releases
# ----------------------------------------

CCF_ARTEFACTS = $(CCF_BSO) $(CCF_SCO) $(CCF_SPO) $(CCF)
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
		reduce --reasoner ELK \
		filter --exclude-terms invalid-terms.txt --trim false \
		annotate --remove-annotations \
			--prefix "dc: http://purl.org/dc/elements/1.1/" \
			--prefix "dcterms: http://purl.org/dc/terms/" \
			--annotation dc:title "Common Coordinate Framework for Biological Structure (CCF-BSO) Ontology" \
			--annotation dc:description "This ontology models the gross anatomyand histology, and the biomarkers that identify cell types." \
			--annotation dcterms:format "application/owl+xml" \
			--link-annotation dcterms:license "https://creativecommons.org/licenses/by/4.0/" \
			--ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) \
			--output $@.tmp.owl && mv $@.tmp.owl $@ \
			
.PRECIOUS: $(CCF_BSO).owl

.PHONY: build_ccf_sco
build_ccf_sco: $(CCF_SCO).owl

$(CCF_SCO).owl: $(CCF_SCO_SRC)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating CCF Specimen (CCF-SCO) ontology)
	$(ROBOT) merge --input $< \
		reason --reasoner ELK --equivalent-classes-allowed asserted-only --exclude-tautologies structural \
		relax \
		reduce -r ELK \
		annotate --remove-annotations \
			--prefix "dc: http://purl.org/dc/elements/1.1/" \
			--prefix "dcterms: http://purl.org/dc/terms/" \
			--annotation dc:title "Common Coordinate Framework for Specimen Data (CCF-SCO) Ontology" \
			--annotation dc:description "This ontology models the concepts that are related to donated tissue samples." \
			--annotation dcterms:format "application/owl+xml" \
			--link-annotation dcterms:license "https://creativecommons.org/licenses/by/4.0/" \
			--ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) \
			--output $@.tmp.owl && mv $@.tmp.owl $@
.PRECIOUS: $(CCF_SCO).owl

.PHONY: build_ccf_spo
build_ccf_spo: $(CCF_SPO).owl

$(CCF_SPO).owl: $(CCF_SPO_SRC)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating CCF Spatial (CCF-SPO) ontology)
	$(ROBOT) merge --input $< \
		reason --reasoner ELK --equivalent-classes-allowed asserted-only --exclude-tautologies structural \
		relax \
		reduce -r ELK \
		annotate --remove-annotations \
			--prefix "dc: http://purl.org/dc/elements/1.1/" \
			--prefix "dcterms: http://purl.org/dc/terms/" \
			--annotation dc:title "Common Coordinate Framework for Spatial Data (CCF-SPO) Ontology" \
			--annotation dc:description "This ontology models the concepts that are needed to construct an anatomical framework for placing specimens in 3-space." \
			--annotation dcterms:format "application/owl+xml" \
			--link-annotation dcterms:license "https://creativecommons.org/licenses/by/4.0/" \
			--ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) \
			--output $@.tmp.owl && mv $@.tmp.owl $@
.PRECIOUS: $(CCF_SPO).owl

.PHONY: build_all
build_all: $(CCF_BSO).owl $(CCF_SCO).owl $(CCF_SPO).owl $(CCF).owl

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
			--prefix "doap: http://usefulinc.com/ns/doap#" \
			--prefix "rdfs: http://www.w3.org/2000/01/rdf-schema#" \
			--annotation rdfs:label "Human Reference Atlas Common Coordinate Framework Ontology" \
			--annotation dc:title "Human Reference Atlas Common Coordinate Framework Ontology" \
			--annotation dc:description "The Common Coordinate Framework (CCF) Ontology is an application ontology built to support the development of the Human Reference Atlas (HRA).  It unifies vocabulary for HRA construction and usage—making it possible to ingest external data sources; supporting uniform tissue sample registration that includes the spatial positioning and semantic annotations within 3D reference organs; and supporting user-formulated cross-domain queries over tissue donor properties, anatomical structures, cell types, biomarkers, and 3D space. The CCF Ontology consists of three major ontologies. The Biological Structure Ontology records anatomical structures, cell types, and biomarkers (ASCT+B) and the relationships between them.  The ASCT+B tables are authored by human experts using templated Google Sheets. The biomarkers, cell types, and anatomical structures are mapped to existing ontologies (Uberon/FMA, CL, HGNC) whenever possible.  All relationships between anatomical structures and from cell types to anatomical structures are valid Uberon and CL relationships. The Spatial Ontology defines the shape, size, location, and rotation of experimental tissue and data major anatomical structures in the 3D Reference Object Library. The Specimen Ontology captures the sex, age, and other information on donors that provided tissue data used in the construction of the HRA." \
			--annotation dcterms:format "application/owl+xml" \
			--annotation doap:GitRepository "https://github.com/hubmapconsortium/ccf-ontology" \
			--annotation rdfs:comment "Contact: Katy Börner (katy@indiana.edu), Bruce W. Herr II (bherr@indiana.edu), David Osumi-Sutherland (davidos@ebi.ac.uk), Josef Hardi (johardi@stanford.edu), Anita Caron (anitac@ebi.ac.uk)" \
			--annotation dcterms:subject "Biomedical Resources, Cell, Human, Anatomy" \
			--link-annotation dcterms:license "https://creativecommons.org/licenses/by/4.0/" \
			--ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) \
			--output $@.tmp.owl && mv $@.tmp.owl $@
.PRECIOUS: $(CCF).owl

# ----------------------------------------
# Clean up
# ----------------------------------------

.PHONY: clean_all
clean_all:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: cleaning up files)
	rm -rf components/* generated/* modules/* extracts/* instances/* ccf.owl ccf-bso.owl ccf-sco.owl ccf-spo.owl
