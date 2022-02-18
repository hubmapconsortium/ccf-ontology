# ----------------------------------------
# Import modules
# ----------------------------------------
# Most ontologies are modularly constructed using portions of other ontologies
# These live in the imports/ folder

IMPORTS_DIR = imports
MIRROR_DIR = mirror

## ONTOLOGY: uberon
$(IMPORTS_DIR)/uberon_import.owl: $(MIRROR_DIR)/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -u "obo:UBERON_0001062" -L imports/uberon_terms.txt --force true --copy-ontology-annotations true --method MIREOT \
		remove --axioms structural-tautologies \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

## ONTOLOGY: cl
$(IMPORTS_DIR)/cl_import.owl: $(MIRROR_DIR)/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -u "obo:CL_0000000" -L imports/cl_terms.txt --force true --copy-ontology-annotations true --method MIREOT \
		remove --axioms structural-tautologies \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

## ONTOLOGY: fma
$(IMPORTS_DIR)/fma_import.owl: $(MIRROR_DIR)/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -u "fma:fma62955" -L imports/fma_terms.txt --force true --copy-ontology-annotations true --method MIREOT \
		remove --axioms structural-tautologies \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

## ONTOLOGY: obi
$(IMPORTS_DIR)/obi_import.owl: $(MIRROR_DIR)/obi.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -u OBI:0100051 -L imports/obi_terms.txt --force true --copy-ontology-annotations true --individuals exclude --method MIREOT \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

## ONTOLOGY: hgnc
$(IMPORTS_DIR)/hgnc_import.owl: $(MIRROR_DIR)/hgnc.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -L imports/hgnc_terms.txt --force true --copy-ontology-annotations true --individuals exclude --method MIREOT \
		remove --axioms structural-tautologies \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

## ONTOLOGY: efo
$(IMPORTS_DIR)/efo_import.owl: $(MIRROR_DIR)/efo.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -u http://www.ebi.ac.uk/efo/EFO_0002694 -L imports/efo_terms.txt --force true --copy-ontology-annotations true --individuals include --method MIREOT \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

## ONTOLOGY: loinc
$(IMPORTS_DIR)/loinc_import.owl: $(MIRROR_DIR)/loinc.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(IMP) = true ] && [ $(IMP_LARGE) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -L imports/loinc_terms.txt --force true --copy-ontology-annotations true --individuals exclude --method MIREOT \
		remove --axioms structural-tautologies \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi
