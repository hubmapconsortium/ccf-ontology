## Customize Makefile settings for CCF ontology
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile

CCF_BSO = $(ONT)-bso
CCF_SCO = $(ONT)-sco
CCF_SPO = $(ONT)-spo
CCF = $(ONT)

CCF_BSO_SRC = $(CCF_BSO)-edit.owl
CCF_SCO_SRC = $(CCF_SCO)-edit.owl
CCF_SPO_SRC = $(CCF_SPO)-edit.owl
CCF_SRC = $(CCF)-edit.owl

# ----------------------------------------
# Component modules
# ----------------------------------------

COMPONENTS_DIR = components
GENERATED_COMP_DIR = $(COMPONENTS_DIR)/generated

ASCTB_ORGANS = \
	blood \
	blood_vasculature \
	bone_marrow \
	brain \
	eye \
	fallopian_tube \
	heart \
	kidney \
	knee \
	large_intestine \
	liver \
	lung \
	lymph_node \
	lymph_vasculature \
	ovary \
	pancreas \
	peripheral_nervous_system \
	prostate \
	skin \
	small_intestine \
	spleen \
	thymus \
	ureter \
	urinary_bladder \
	uterus

ASCTB_FILES = $(patsubst %, $(COMPONENTS_DIR)/asctb_%.owl, $(ASCTB_ORGANS))
PARTONOMY_FILES = $(patsubst %, $(GENERATED_COMP_DIR)/ccf_partonomy_%.owl, $(ASCTB_ORGANS))
CELL_BIOMARKERS_FILES = $(patsubst %, $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_%.owl, $(ASCTB_ORGANS))
ASCTB_ANNOTATIONS_FILES = $(patsubst %, $(GENERATED_COMP_DIR)/ccf_asctb_annotations_%.owl, $(ASCTB_ORGANS))

COMP = true

COMPONENT_FILES = \
	$(PARTONOMY_FILES) \
	$(CELL_BIOMARKERS_FILES) \
	$(ASCTB_ANNOTATIONS_FILES) \
	$(ASCTB_FILES)

.PHONY: all_components
all_components: $(COMPONENT_FILES)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Finish generating component files:)
	$(foreach n, $(PARTONOMY_FILES), $(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: - $(n)))
	$(foreach n, $(CELL_BIOMARKERS_FILES), $(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: - $(n)))
	$(foreach n, $(ASCTB_ANNOTATIONS_FILES), $(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: - $(n)))
	$(foreach n, $(ASCTB_FILES), $(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: - $(n)))

define download_ccf_partonomy_component
	if [ $(COMP) = true ]; then wget -nc https://raw.githubusercontent.com/hubmapconsortium/ccf-validation-tools/master/owl/ccf_${1}_classes.owl -O $@.tmp.owl && \
		$(ROBOT) annotate -i $@.tmp.owl --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi
endef

## DOWNLOAD-COMPONENT: CCF_AS_CT
# $(COMPONENTS_DIR)/ccf_as_ct.owl:
#   $(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
#   wget -nc https://raw.githubusercontent.com/hubmapconsortium/ccf-validation-tools/master/owl/CCF_AS_CT.owl -O $@.tmp.owl && \
#   $(ROBOT) annotate -i $@.tmp.owl --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@;
# .PRECIOUS: $(COMPONENTS_DIR)/ccf_as_ct.owl

$(GENERATED_COMP_DIR)/ccf_partonomy_blood.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Blood)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_partonomy_blood.owl

$(GENERATED_COMP_DIR)/ccf_partonomy_blood_vasculature.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Blood_vasculature)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_partonomy_blood_vasculature.owl

$(GENERATED_COMP_DIR)/ccf_partonomy_bone_marrow.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Bone-Marrow)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_partonomy_bone_marrow.owl

$(GENERATED_COMP_DIR)/ccf_partonomy_brain.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Brain)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_partonomy_brain.owl

$(GENERATED_COMP_DIR)/ccf_partonomy_eye.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Eye)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_partonomy_eye.owl

$(GENERATED_COMP_DIR)/ccf_partonomy_fallopian_tube.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Fallopian_tube)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_partonomy_fallopian_tube.owl

$(GENERATED_COMP_DIR)/ccf_partonomy_heart.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Heart)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_partonomy_heart.owl

$(GENERATED_COMP_DIR)/ccf_partonomy_kidney.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Kidney)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_partonomy_kidney.owl

$(GENERATED_COMP_DIR)/ccf_partonomy_knee.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Knee)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_partonomy_knee.owl

$(GENERATED_COMP_DIR)/ccf_partonomy_large_intestine.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Large_intestine)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_partonomy_large_intestine.owl

$(GENERATED_COMP_DIR)/ccf_partonomy_liver.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Liver)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_partonomy_liver.owl

$(GENERATED_COMP_DIR)/ccf_partonomy_lung.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Lung)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_partonomy_lung.owl

$(GENERATED_COMP_DIR)/ccf_partonomy_lymph_node.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Lymph_node)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_partonomy_lymph_node.owl

$(GENERATED_COMP_DIR)/ccf_partonomy_lymph_vasculature.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Lymph_vasculature)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_partonomy_lymph_vasculature.owl

$(GENERATED_COMP_DIR)/ccf_partonomy_ovary.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Ovary)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_partonomy_ovary.owl

$(GENERATED_COMP_DIR)/ccf_partonomy_pancreas.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Pancreas)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_partonomy_pancreas.owl

$(GENERATED_COMP_DIR)/ccf_partonomy_peripheral_nervous_system.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Peripheral_nervous_system)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_partonomy_peripheral_nervous_system.owl

$(GENERATED_COMP_DIR)/ccf_partonomy_prostate.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Prostate)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_partonomy_prostate.owl

$(GENERATED_COMP_DIR)/ccf_partonomy_skin.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Skin)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_partonomy_skin.owl

$(GENERATED_COMP_DIR)/ccf_partonomy_small_intestine.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Small_intestine)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_partonomy_small_intestine.owl

$(GENERATED_COMP_DIR)/ccf_partonomy_spleen.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Spleen)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_partonomy_spleen.owl

$(GENERATED_COMP_DIR)/ccf_partonomy_thymus.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Thymus)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_partonomy_thymus.owl

$(GENERATED_COMP_DIR)/ccf_partonomy_ureter.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Ureter)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_partonomy_ureter.owl

$(GENERATED_COMP_DIR)/ccf_partonomy_urinary_bladder.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Urinary_bladder)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_partonomy_urinary_bladder.owl

$(GENERATED_COMP_DIR)/ccf_partonomy_uterus.owl:
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Downloading $@)
	$(call download_ccf_partonomy_component,Uterus)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_partonomy_uterus.owl

# ----------------------------------------

.PHONY: check_asctb2ccf
check_asctb2ccf:
	@type asctb2ccf > /dev/null 2>&1 || (echo "ERROR: asctb2ccf is required, please visit https://github.com/hubmapconsortium/asctb2ccf to install"; exit 1)

define generate_ccf_asctb_annotations_component
	if [ $(COMP) = true ]; then asctb2ccf --organ-name $(1) --ontology-iri $(ONTBASE)/$@ -o $@.tmp.owl && \
		$(ROBOT) annotate --input $@.tmp.owl --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi
endef

define generate_ccf_cell_biomarkers_component
	if [ $(COMP) = true ]; then asctb2ccf --organ-name $(1) --cell-biomarkers-only --ontology-iri $(ONTBASE)/$@ -o $@.tmp.owl && \
		$(ROBOT) annotate --input $@.tmp.owl --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi
endef

$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_blood.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,Blood)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_blood.owl

$(GENERATED_COMP_DIR)/ccf_asctb_annotations_blood.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,Blood)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_blood.owl

$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_blood_vasculature.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,BloodVasculature)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_blood_vasculature.owl

$(GENERATED_COMP_DIR)/ccf_asctb_annotations_blood_vasculature.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,BloodVasculature)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_blood_vasculature.owl

$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_bone_marrow.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,BoneMarrow)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_bone_marrow.owl

$(GENERATED_COMP_DIR)/ccf_asctb_annotations_bone_marrow.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,BoneMarrow)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_bone_marrow.owl

$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_brain.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,Brain)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_brain.owl

$(GENERATED_COMP_DIR)/ccf_asctb_annotations_brain.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,Brain)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_brain.owl

$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_eye.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,Eye)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_eye.owl

$(GENERATED_COMP_DIR)/ccf_asctb_annotations_eye.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,Eye)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_eye.owl

$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_fallopian_tube.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,FallopianTube)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_fallopian_tube.owl

$(GENERATED_COMP_DIR)/ccf_asctb_annotations_fallopian_tube.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,FallopianTube)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_fallopian_tube.owl

$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_heart.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,Heart)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_heart.owl

$(GENERATED_COMP_DIR)/ccf_asctb_annotations_heart.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,Heart)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_heart.owl

$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_kidney.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,Kidney)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_kidney.owl

$(GENERATED_COMP_DIR)/ccf_asctb_annotations_kidney.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,Kidney)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_kidney.owl

$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_knee.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,Knee)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_knee.owl

$(GENERATED_COMP_DIR)/ccf_asctb_annotations_knee.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,Knee)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_knee.owl

$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_large_intestine.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,LargeIntestine)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_large_intestine.owl

$(GENERATED_COMP_DIR)/ccf_asctb_annotations_large_intestine.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,LargeIntestine)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_large_intestine.owl

$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_liver.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,Liver)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_liver.owl

$(GENERATED_COMP_DIR)/ccf_asctb_annotations_liver.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,Liver)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_liver.owl

$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_lung.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,Lung)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_lung.owl

$(GENERATED_COMP_DIR)/ccf_asctb_annotations_lung.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,Lung)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_lung.owl

$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_lymph_node.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,LymphNode)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_lymph_node.owl

$(GENERATED_COMP_DIR)/ccf_asctb_annotations_lymph_node.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,LymphNode)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_lymph_node.owl

$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_lymph_vasculature.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,LymphVasculature)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_lymph_vasculature.owl

$(GENERATED_COMP_DIR)/ccf_asctb_annotations_lymph_vasculature.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,LymphVasculature)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_lymph_vasculature.owl

$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_ovary.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,Ovary)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_ovary.owl

$(GENERATED_COMP_DIR)/ccf_asctb_annotations_ovary.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,Ovary)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_ovary.owl

$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_pancreas.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,Pancreas)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_pancreas.owl

$(GENERATED_COMP_DIR)/ccf_asctb_annotations_pancreas.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,Pancreas)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_pancreas.owl

$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_peripheral_nervous_system.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,PeripheralNervousSystem)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_peripheral_nervous_system.owl

$(GENERATED_COMP_DIR)/ccf_asctb_annotations_peripheral_nervous_system.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,PeripheralNervousSystem)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_peripheral_nervous_system.owl

$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_prostate.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,Prostate)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_prostate.owl

$(GENERATED_COMP_DIR)/ccf_asctb_annotations_prostate.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,Prostate)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_prostate.owl

$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_skin.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,Skin)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_skin.owl

$(GENERATED_COMP_DIR)/ccf_asctb_annotations_skin.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,Skin)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_skin.owl

$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_small_intestine.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,SmallIntestine)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_small_intestine.owl

$(GENERATED_COMP_DIR)/ccf_asctb_annotations_small_intestine.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,SmallIntestine)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_small_intestine.owl

$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_spleen.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,Spleen)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_spleen.owl

$(GENERATED_COMP_DIR)/ccf_asctb_annotations_spleen.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,Spleen)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_spleen.owl

$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_thymus.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,Thymus)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_thymus.owl

$(GENERATED_COMP_DIR)/ccf_asctb_annotations_thymus.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,Thymus)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_thymus.owl

$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_ureter.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,Ureter)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_ureter.owl

$(GENERATED_COMP_DIR)/ccf_asctb_annotations_ureter.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,Ureter)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_ureter.owl

$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_urinary_bladder.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,UrinaryBladder)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_urinary_bladder.owl

$(GENERATED_COMP_DIR)/ccf_asctb_annotations_urinary_bladder.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,UrinaryBladder)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_urinary_bladder.owl

$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_uterus.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_cell_biomarkers_component,Uterus)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_cell_biomarkers_uterus.owl

$(GENERATED_COMP_DIR)/ccf_asctb_annotations_uterus.owl: check_asctb2ccf
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call generate_ccf_asctb_annotations_component,Uterus)
.PRECIOUS: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_uterus.owl


# ----------------------------------------
# Extract modules
# ----------------------------------------

EXTRACTS_DIR = extracts

UBERON_EXTRACTS = $(ASCTB_ORGANS)
UBERON_EXTRACT_FILES = $(patsubst %, $(EXTRACTS_DIR)/uberon_%.owl, $(UBERON_EXTRACTS))

FMA_EXTRACTS = \
	heart \
	lung \
	blood_vasculature \
	lymph_vasculature \
	ovary \
	pancreas \
	peripheral_nervous_system \
	small_intestine \
	uterus
FMA_EXTRACT_FILES = $(patsubst %, $(EXTRACTS_DIR)/fma_%.owl, $(FMA_EXTRACTS))

CL_EXTRACTS = $(ASCTB_ORGANS)
CL_EXTRACT_FILES = $(patsubst %, $(EXTRACTS_DIR)/cl_%.owl, $(CL_EXTRACTS))

LMHA_EXTRACTS = lung
LMHA_EXTRACT_FILES = $(patsubst %, $(EXTRACTS_DIR)/lmha_%.owl, $(LMHA_EXTRACTS))

EXTRACT_FILES = \
	$(UBERON_EXTRACT_FILES) \
	$(FMA_EXTRACT_FILES) \
	$(CL_EXTRACT_FILES) \
	$(LMHA_EXTRACT_FILES)

EXT = true

.PHONY: all_extracts
all_extracts: $(EXTRACT_FILES)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Finish generating extract files:)
	$(foreach n, $(UBERON_EXTRACT_FILES), $(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: - $(n)))
	$(foreach n, $(FMA_EXTRACT_FILES), $(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: - $(n)))
	$(foreach n, $(CL_EXTRACT_FILES), $(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: - $(n)))
	$(foreach n, $(LMHA_EXTRACT_FILES), $(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: - $(n)))

INTERMEDIATES_OPT = none

define extract_uberon_terms
	if [ $(EXT) = true ]; then $(ROBOT) query --input $(1) --query queries/get_uberon_entities.sparql /tmp/entities.csv && \
		sed -i '' 1d /tmp/entities.csv && \
		$(ROBOT) extract --method MIREOT --input $(2) --upper-term "obo:UBERON_0001062" --lower-terms /tmp/entities.csv --intermediates $(INTERMEDIATES_OPT) \
				 annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@ && \
		rm /tmp/entities.csv; fi
endef

define extract_fma_terms
	if [ $(EXT) = true ]; then $(ROBOT) query --input $(1) --query queries/get_fma_entities.sparql /tmp/entities.csv && \
		sed -i '' 1d /tmp/entities.csv && \
		$(ROBOT) extract --method MIREOT --input $(2) --upper-term "http://purl.org/sig/ont/fma/fma62955" --lower-terms /tmp/entities.csv --intermediates $(INTERMEDIATES_OPT) \
				 annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@ && \
		rm /tmp/entities.csv; fi
endef

define extract_cl_terms
	if [ $(EXT) = true ]; then $(ROBOT) query --input $(1) --query queries/get_cl_entities.sparql /tmp/entities.csv && \
		sed -i '' 1d /tmp/entities.csv && \
		$(ROBOT) extract --method MIREOT --input $(2) --upper-term "obo:CL_0000000" --lower-terms /tmp/entities.csv --intermediates $(INTERMEDIATES_OPT) \
				 annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@ && \
		rm /tmp/entities.csv; fi
endef

define extract_lmha_terms
	if [ $(EXT) = true ]; then $(ROBOT) query --input $(1) --query queries/get_lmha_entities.sparql /tmp/entities.csv && \
		sed -i '' 1d /tmp/entities.csv && \
		$(ROBOT) extract --method MIREOT --input $(2) --upper-term "obo:LMHA_00135" --lower-terms /tmp/entities.csv --intermediates $(INTERMEDIATES_OPT) \
				 annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@ && \
		rm /tmp/entities.csv; fi
endef

$(EXTRACTS_DIR)/uberon_blood.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_blood.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_blood.owl

$(EXTRACTS_DIR)/uberon_blood_vasculature.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_blood_vasculature.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_blood_vasculature.owl

$(EXTRACTS_DIR)/uberon_bone_marrow.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_bone_marrow.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_bone_marrow.owl

$(EXTRACTS_DIR)/uberon_brain.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_brain.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_brain.owl

$(EXTRACTS_DIR)/uberon_eye.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_eye.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_eye.owl

$(EXTRACTS_DIR)/uberon_fallopian_tube.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_fallopian_tube.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_fallopian_tube.owl

$(EXTRACTS_DIR)/uberon_heart.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_heart.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_heart.owl

$(EXTRACTS_DIR)/uberon_kidney.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_kidney.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_kidney.owl

$(EXTRACTS_DIR)/uberon_knee.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_knee.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_knee.owl

$(EXTRACTS_DIR)/uberon_large_intestine.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_large_intestine.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_large_intestine.owl

$(EXTRACTS_DIR)/uberon_liver.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_liver.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_liver.owl

$(EXTRACTS_DIR)/uberon_lung.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_lung.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_lung.owl

$(EXTRACTS_DIR)/uberon_lymph_node.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_lymph_node.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_lymph_node.owl

$(EXTRACTS_DIR)/uberon_lymph_vasculature.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_lymph_vasculature.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_lymph_vasculature.owl

$(EXTRACTS_DIR)/uberon_ovary.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_ovary.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_ovary.owl

$(EXTRACTS_DIR)/uberon_pancreas.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_pancreas.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_pancreas.owl

$(EXTRACTS_DIR)/uberon_peripheral_nervous_system.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_peripheral_nervous_system.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_peripheral_nervous_system.owl

$(EXTRACTS_DIR)/uberon_prostate.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_prostate.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_prostate.owl

$(EXTRACTS_DIR)/uberon_skin.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_skin.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_skin.owl

$(EXTRACTS_DIR)/uberon_small_intestine.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_small_intestine.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_small_intestine.owl

$(EXTRACTS_DIR)/uberon_spleen.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_spleen.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_spleen.owl

$(EXTRACTS_DIR)/uberon_thymus.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_thymus.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_thymus.owl

$(EXTRACTS_DIR)/uberon_ureter.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_ureter.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_ureter.owl

$(EXTRACTS_DIR)/uberon_urinary_bladder.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_urinary_bladder.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_urinary_bladder.owl

$(EXTRACTS_DIR)/uberon_uterus.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_uterus.owl mirror/uberon.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_uberon_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/uberon_uterus.owl

# ----------------------------------------

$(EXTRACTS_DIR)/fma_heart.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_heart.owl mirror/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_fma_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/fma_heart.owl

$(EXTRACTS_DIR)/fma_lung.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_lung.owl mirror/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_fma_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/fma_lung.owl

$(EXTRACTS_DIR)/fma_blood_vasculature.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_blood_vasculature.owl mirror/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_fma_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/fma_blood_vasculature.owl

$(EXTRACTS_DIR)/fma_lymph_vasculature.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_lymph_vasculature.owl mirror/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_fma_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/fma_lymph_vasculature.owl

$(EXTRACTS_DIR)/fma_ovary.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_ovary.owl mirror/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_fma_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/fma_ovary.owl

$(EXTRACTS_DIR)/fma_pancreas.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_pancreas.owl mirror/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_fma_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/fma_pancreas.owl

$(EXTRACTS_DIR)/fma_peripheral_nervous_system.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_peripheral_nervous_system.owl mirror/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_fma_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/fma_peripheral_nervous_system.owl

$(EXTRACTS_DIR)/fma_small_intestine.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_small_intestine.owl mirror/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_fma_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/fma_small_intestine.owl

$(EXTRACTS_DIR)/fma_uterus.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_uterus.owl mirror/fma.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_fma_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/fma_uterus.owl

# ----------------------------------------

$(EXTRACTS_DIR)/cl_blood.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_blood.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_blood.owl

$(EXTRACTS_DIR)/cl_blood_vasculature.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_blood_vasculature.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_blood_vasculature.owl

$(EXTRACTS_DIR)/cl_bone_marrow.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_bone_marrow.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_bone_marrow.owl

$(EXTRACTS_DIR)/cl_brain.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_brain.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Skipping $@)
# 	$(call extract_cl_terms,$(word 1,$^),$(word 2,$^))
#.PRECIOUS: $(EXTRACTS_DIR)/cl_brain.owl

$(EXTRACTS_DIR)/cl_eye.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_eye.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_eye.owl

$(EXTRACTS_DIR)/cl_fallopian_tube.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_fallopian_tube.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Skipping $@)
# 	$(call extract_cl_terms,$(word 1,$^),$(word 2,$^))
# .PRECIOUS: $(EXTRACTS_DIR)/cl_fallopian_tube.owl

$(EXTRACTS_DIR)/cl_heart.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_heart.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_heart.owl

$(EXTRACTS_DIR)/cl_kidney.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_kidney.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_kidney.owl

$(EXTRACTS_DIR)/cl_knee.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_knee.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_knee.owl

$(EXTRACTS_DIR)/cl_large_intestine.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_large_intestine.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_large_intestine.owl

$(EXTRACTS_DIR)/cl_liver.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_liver.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_liver.owl

$(EXTRACTS_DIR)/cl_lung.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_lung.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_lung.owl

$(EXTRACTS_DIR)/cl_lymph_node.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_lymph_node.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_lymph_node.owl

$(EXTRACTS_DIR)/cl_lymph_vasculature.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_lymph_vasculature.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_lymph_vasculature.owl

$(EXTRACTS_DIR)/cl_ovary.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_ovary.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_ovary.owl

$(EXTRACTS_DIR)/cl_pancreas.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_pancreas.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_pancreas.owl

$(EXTRACTS_DIR)/cl_peripheral_nervous_system.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_peripheral_nervous_system.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_peripheral_nervous_system.owl

$(EXTRACTS_DIR)/cl_prostate.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_prostate.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_prostate.owl

$(EXTRACTS_DIR)/cl_skin.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_skin.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_skin.owl

$(EXTRACTS_DIR)/cl_small_intestine.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_small_intestine.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_small_intestine.owl

$(EXTRACTS_DIR)/cl_spleen.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_spleen.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_spleen.owl

$(EXTRACTS_DIR)/cl_thymus.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_thymus.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_thymus.owl

$(EXTRACTS_DIR)/cl_ureter.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_ureter.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_ureter.owl

$(EXTRACTS_DIR)/cl_urinary_bladder.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_urinary_bladder.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_urinary_bladder.owl

$(EXTRACTS_DIR)/cl_uterus.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_uterus.owl mirror/cl.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	$(call extract_cl_terms,$(word 1,$^),$(word 2,$^))
.PRECIOUS: $(EXTRACTS_DIR)/cl_uterus.owl

# ----------------------------------------

$(EXTRACTS_DIR)/lmha_lung.owl: $(GENERATED_COMP_DIR)/ccf_asctb_annotations_lung.owl mirror/lmha.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Skipping $@)
# 	$(call extract_lmha_terms,$(word 1,$^),$(word 2,$^))
# .PRECIOUS: $(EXTRACTS_DIR)/lmha_lung.owl


# ----------------------------------------
# ASCT+B Components
# ----------------------------------------

.PHONY: all_asctb
all_asctb: $(ASCTB_FILES)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Finish generating ASCT+B files:)
	$(foreach n, $(ASCTB_FILES), $(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: - $(n)))

define make_asctb_component
	if [ $(COMP) = true ]; then $(ROBOT) merge --input $(1) \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv -f $@.tmp.owl $@; fi
endef

$(COMPONENTS_DIR)/asctb_blood.owl: $(COMPONENTS_DIR)/asctb_blood-edit.owl \
									$(GENERATED_COMP_DIR)/ccf_partonomy_blood.owl \
									$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_blood.owl \
									$(GENERATED_COMP_DIR)/ccf_asctb_annotations_blood.owl \
									$(EXTRACTS_DIR)/uberon_blood.owl \
									$(EXTRACTS_DIR)/cl_blood.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 1,$^))
.PRECIOUS: $(COMPONENTS_DIR)/asctb_blood.owl

$(COMPONENTS_DIR)/asctb_blood_vasculature.owl: $(COMPONENTS_DIR)/asctb_blood_vasculature-edit.owl \
									$(GENERATED_COMP_DIR)/ccf_partonomy_blood_vasculature.owl \
									$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_blood_vasculature.owl \
									$(GENERATED_COMP_DIR)/ccf_asctb_annotations_blood_vasculature.owl \
									$(EXTRACTS_DIR)/uberon_blood_vasculature.owl \
									$(EXTRACTS_DIR)/cl_blood_vasculature.owl \
									$(EXTRACTS_DIR)/fma_blood_vasculature.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 1,$^))
.PRECIOUS: $(COMPONENTS_DIR)/asctb_blood_vasculature.owl

$(COMPONENTS_DIR)/asctb_bone_marrow.owl: $(COMPONENTS_DIR)/asctb_bone_marrow-edit.owl \
									$(GENERATED_COMP_DIR)/ccf_partonomy_bone_marrow.owl \
									$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_bone_marrow.owl \
									$(GENERATED_COMP_DIR)/ccf_asctb_annotations_bone_marrow.owl \
									$(EXTRACTS_DIR)/uberon_bone_marrow.owl \
									$(EXTRACTS_DIR)/cl_bone_marrow.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 1,$^))
.PRECIOUS: $(COMPONENTS_DIR)/asctb_bone_marrow.owl

$(COMPONENTS_DIR)/asctb_brain.owl: $(COMPONENTS_DIR)/asctb_brain-edit.owl \
									$(GENERATED_COMP_DIR)/ccf_partonomy_brain.owl \
									$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_brain.owl \
									$(GENERATED_COMP_DIR)/ccf_asctb_annotations_brain.owl \
									$(EXTRACTS_DIR)/uberon_brain.owl \
									$(EXTRACTS_DIR)/cl_brain.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 1,$^))
.PRECIOUS: $(COMPONENTS_DIR)/asctb_brain.owl

$(COMPONENTS_DIR)/asctb_eye.owl: $(COMPONENTS_DIR)/asctb_eye-edit.owl \
									$(GENERATED_COMP_DIR)/ccf_partonomy_eye.owl \
									$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_eye.owl \
									$(GENERATED_COMP_DIR)/ccf_asctb_annotations_eye.owl \
									$(EXTRACTS_DIR)/uberon_eye.owl \
									$(EXTRACTS_DIR)/cl_eye.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 1,$^))
.PRECIOUS: $(COMPONENTS_DIR)/asctb_eye.owl

$(COMPONENTS_DIR)/asctb_fallopian_tube.owl: $(COMPONENTS_DIR)/asctb_fallopian_tube-edit.owl \
									$(GENERATED_COMP_DIR)/ccf_partonomy_fallopian_tube.owl \
									$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_fallopian_tube.owl \
									$(GENERATED_COMP_DIR)/ccf_asctb_annotations_fallopian_tube.owl \
									$(EXTRACTS_DIR)/uberon_fallopian_tube.owl \
									$(EXTRACTS_DIR)/cl_fallopian_tube.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 1,$^))
.PRECIOUS: $(COMPONENTS_DIR)/asctb_fallopian_tube.owl

$(COMPONENTS_DIR)/asctb_heart.owl: $(COMPONENTS_DIR)/asctb_heart-edit.owl \
									$(GENERATED_COMP_DIR)/ccf_partonomy_heart.owl \
									$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_heart.owl \
									$(GENERATED_COMP_DIR)/ccf_asctb_annotations_heart.owl \
									$(EXTRACTS_DIR)/uberon_heart.owl \
									$(EXTRACTS_DIR)/cl_heart.owl \
									$(EXTRACTS_DIR)/fma_heart.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 1,$^))
.PRECIOUS: $(COMPONENTS_DIR)/asctb_heart.owl

$(COMPONENTS_DIR)/asctb_kidney.owl: $(COMPONENTS_DIR)/asctb_kidney-edit.owl \
									$(GENERATED_COMP_DIR)/ccf_partonomy_kidney.owl \
									$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_kidney.owl \
									$(GENERATED_COMP_DIR)/ccf_asctb_annotations_kidney.owl \
									$(EXTRACTS_DIR)/uberon_kidney.owl \
									$(EXTRACTS_DIR)/cl_kidney.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 1,$^))
.PRECIOUS: $(COMPONENTS_DIR)/asctb_kidney.owl

$(COMPONENTS_DIR)/asctb_knee.owl: $(COMPONENTS_DIR)/asctb_knee-edit.owl \
									$(GENERATED_COMP_DIR)/ccf_partonomy_knee.owl \
									$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_knee.owl \
									$(GENERATED_COMP_DIR)/ccf_asctb_annotations_knee.owl \
									$(EXTRACTS_DIR)/uberon_knee.owl \
									$(EXTRACTS_DIR)/cl_knee.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 1,$^))
.PRECIOUS: $(COMPONENTS_DIR)/asctb_knee.owl

$(COMPONENTS_DIR)/asctb_large_intestine.owl: $(COMPONENTS_DIR)/asctb_large_intestine-edit.owl \
									$(GENERATED_COMP_DIR)/ccf_partonomy_large_intestine.owl \
									$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_large_intestine.owl \
									$(GENERATED_COMP_DIR)/ccf_asctb_annotations_large_intestine.owl \
									$(EXTRACTS_DIR)/uberon_large_intestine.owl \
									$(EXTRACTS_DIR)/cl_large_intestine.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 1,$^))
.PRECIOUS: $(COMPONENTS_DIR)/asctb_large_intestine.owl

$(COMPONENTS_DIR)/asctb_liver.owl: $(COMPONENTS_DIR)/asctb_liver-edit.owl \
									$(GENERATED_COMP_DIR)/ccf_partonomy_liver.owl \
									$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_liver.owl \
									$(GENERATED_COMP_DIR)/ccf_asctb_annotations_liver.owl \
									$(EXTRACTS_DIR)/uberon_liver.owl \
									$(EXTRACTS_DIR)/cl_liver.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 1,$^))
.PRECIOUS: $(COMPONENTS_DIR)/asctb_liver.owl

$(COMPONENTS_DIR)/asctb_lung.owl: $(COMPONENTS_DIR)/asctb_lung-edit.owl \
									$(GENERATED_COMP_DIR)/ccf_partonomy_lung.owl \
									$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_lung.owl \
									$(GENERATED_COMP_DIR)/ccf_asctb_annotations_lung.owl \
									$(EXTRACTS_DIR)/uberon_lung.owl \
									$(EXTRACTS_DIR)/cl_lung.owl \
									$(EXTRACTS_DIR)/fma_lung.owl \
									$(EXTRACTS_DIR)/lmha_lung.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 1,$^))
.PRECIOUS: $(COMPONENTS_DIR)/asctb_lung.owl

$(COMPONENTS_DIR)/asctb_lymph_node.owl: $(COMPONENTS_DIR)/asctb_lymph_node-edit.owl \
									$(GENERATED_COMP_DIR)/ccf_partonomy_lymph_node.owl \
									$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_lymph_node.owl \
									$(GENERATED_COMP_DIR)/ccf_asctb_annotations_lymph_node.owl \
									$(EXTRACTS_DIR)/uberon_lymph_node.owl \
									$(EXTRACTS_DIR)/cl_lymph_node.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 1,$^))
.PRECIOUS: $(COMPONENTS_DIR)/asctb_lymph_node.owl

$(COMPONENTS_DIR)/asctb_lymph_vasculature.owl: $(COMPONENTS_DIR)/asctb_lymph_vasculature-edit.owl \
									$(GENERATED_COMP_DIR)/ccf_partonomy_lymph_vasculature.owl \
									$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_lymph_vasculature.owl \
									$(GENERATED_COMP_DIR)/ccf_asctb_annotations_lymph_vasculature.owl \
									$(EXTRACTS_DIR)/uberon_lymph_vasculature.owl \
									$(EXTRACTS_DIR)/cl_lymph_vasculature.owl \
									$(EXTRACTS_DIR)/fma_lymph_vasculature.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 1,$^))
.PRECIOUS: $(COMPONENTS_DIR)/asctb_lymph_vasculature.owl

$(COMPONENTS_DIR)/asctb_ovary.owl: $(COMPONENTS_DIR)/asctb_ovary-edit.owl \
									$(GENERATED_COMP_DIR)/ccf_partonomy_ovary.owl \
									$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_ovary.owl \
									$(GENERATED_COMP_DIR)/ccf_asctb_annotations_ovary.owl \
									$(EXTRACTS_DIR)/uberon_ovary.owl \
									$(EXTRACTS_DIR)/cl_ovary.owl \
									$(EXTRACTS_DIR)/fma_ovary.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 1,$^))
.PRECIOUS: $(COMPONENTS_DIR)/asctb_ovary.owl

$(COMPONENTS_DIR)/asctb_pancreas.owl: $(COMPONENTS_DIR)/asctb_pancreas-edit.owl \
									$(GENERATED_COMP_DIR)/ccf_partonomy_pancreas.owl \
									$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_pancreas.owl \
									$(GENERATED_COMP_DIR)/ccf_asctb_annotations_pancreas.owl \
									$(EXTRACTS_DIR)/uberon_pancreas.owl \
									$(EXTRACTS_DIR)/cl_pancreas.owl \
									$(EXTRACTS_DIR)/fma_pancreas.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 1,$^))
.PRECIOUS: $(COMPONENTS_DIR)/asctb_pancreas.owl

$(COMPONENTS_DIR)/asctb_peripheral_nervous_system.owl: $(COMPONENTS_DIR)/asctb_peripheral_nervous_system-edit.owl \
									$(GENERATED_COMP_DIR)/ccf_partonomy_peripheral_nervous_system.owl \
									$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_peripheral_nervous_system.owl \
									$(GENERATED_COMP_DIR)/ccf_asctb_annotations_peripheral_nervous_system.owl \
									$(EXTRACTS_DIR)/uberon_peripheral_nervous_system.owl \
									$(EXTRACTS_DIR)/cl_peripheral_nervous_system.owl \
									$(EXTRACTS_DIR)/fma_peripheral_nervous_system.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 1,$^))
.PRECIOUS: $(COMPONENTS_DIR)/asctb_peripheral_nervous_system.owl

$(COMPONENTS_DIR)/asctb_prostate.owl: $(COMPONENTS_DIR)/asctb_prostate-edit.owl \
									$(GENERATED_COMP_DIR)/ccf_partonomy_prostate.owl \
									$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_prostate.owl \
									$(GENERATED_COMP_DIR)/ccf_asctb_annotations_prostate.owl \
									$(EXTRACTS_DIR)/uberon_prostate.owl \
									$(EXTRACTS_DIR)/cl_prostate.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 1,$^))
.PRECIOUS: $(COMPONENTS_DIR)/asctb_prostate.owl

$(COMPONENTS_DIR)/asctb_skin.owl: $(COMPONENTS_DIR)/asctb_skin-edit.owl \
									$(GENERATED_COMP_DIR)/ccf_partonomy_skin.owl \
									$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_skin.owl \
									$(GENERATED_COMP_DIR)/ccf_asctb_annotations_skin.owl \
									$(EXTRACTS_DIR)/uberon_skin.owl \
									$(EXTRACTS_DIR)/cl_skin.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 1,$^))
.PRECIOUS: $(COMPONENTS_DIR)/asctb_skin.owl

$(COMPONENTS_DIR)/asctb_small_intestine.owl: $(COMPONENTS_DIR)/asctb_small_intestine-edit.owl \
									$(GENERATED_COMP_DIR)/ccf_partonomy_small_intestine.owl \
									$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_small_intestine.owl \
									$(GENERATED_COMP_DIR)/ccf_asctb_annotations_small_intestine.owl \
									$(EXTRACTS_DIR)/uberon_small_intestine.owl \
									$(EXTRACTS_DIR)/cl_small_intestine.owl \
									$(EXTRACTS_DIR)/fma_small_intestine.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 1,$^))
.PRECIOUS: $(COMPONENTS_DIR)/asctb_small_intestine.owl

$(COMPONENTS_DIR)/asctb_spleen.owl: $(COMPONENTS_DIR)/asctb_spleen-edit.owl \
									$(GENERATED_COMP_DIR)/ccf_partonomy_spleen.owl \
									$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_spleen.owl \
									$(GENERATED_COMP_DIR)/ccf_asctb_annotations_spleen.owl \
									$(EXTRACTS_DIR)/uberon_spleen.owl \
									$(EXTRACTS_DIR)/cl_spleen.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 1,$^))
.PRECIOUS: $(COMPONENTS_DIR)/asctb_spleen.owl

$(COMPONENTS_DIR)/asctb_thymus.owl: $(COMPONENTS_DIR)/asctb_thymus-edit.owl \
									$(GENERATED_COMP_DIR)/ccf_partonomy_thymus.owl \
									$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_thymus.owl \
									$(GENERATED_COMP_DIR)/ccf_asctb_annotations_thymus.owl \
									$(EXTRACTS_DIR)/uberon_thymus.owl \
									$(EXTRACTS_DIR)/cl_thymus.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 1,$^))
.PRECIOUS: $(COMPONENTS_DIR)/asctb_thymus.owl

$(COMPONENTS_DIR)/asctb_ureter.owl: $(COMPONENTS_DIR)/asctb_ureter-edit.owl \
									$(GENERATED_COMP_DIR)/ccf_partonomy_ureter.owl \
									$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_ureter.owl \
									$(GENERATED_COMP_DIR)/ccf_asctb_annotations_ureter.owl \
									$(EXTRACTS_DIR)/uberon_ureter.owl \
									$(EXTRACTS_DIR)/cl_ureter.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 1,$^))
.PRECIOUS: $(COMPONENTS_DIR)/asctb_ureter.owl

$(COMPONENTS_DIR)/asctb_urinary_bladder.owl: $(COMPONENTS_DIR)/asctb_urinary_bladder-edit.owl \
									$(GENERATED_COMP_DIR)/ccf_partonomy_urinary_bladder.owl \
									$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_urinary_bladder.owl \
									$(GENERATED_COMP_DIR)/ccf_asctb_annotations_urinary_bladder.owl \
									$(EXTRACTS_DIR)/uberon_urinary_bladder.owl \
									$(EXTRACTS_DIR)/cl_urinary_bladder.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 1,$^))
.PRECIOUS: $(COMPONENTS_DIR)/asctb_urinary_bladder.owl

$(COMPONENTS_DIR)/asctb_uterus.owl: $(COMPONENTS_DIR)/asctb_uterus-edit.owl \
									$(GENERATED_COMP_DIR)/ccf_partonomy_uterus.owl \
									$(GENERATED_COMP_DIR)/ccf_cell_biomarkers_uterus.owl \
									$(GENERATED_COMP_DIR)/ccf_asctb_annotations_uterus.owl \
									$(EXTRACTS_DIR)/uberon_uterus.owl \
									$(EXTRACTS_DIR)/cl_uterus.owl \
									$(EXTRACTS_DIR)/fma_uterus.owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Making $@)
	$(call make_asctb_component,$(word 1,$^))
.PRECIOUS: $(COMPONENTS_DIR)/asctb_uterus.owl


# ----------------------------------------
# Data Mirror Module
# ----------------------------------------

DATA_MIRROR_DIR = data/mirror

DATAMIRRORS = \
	reference-spatial-entities \
	generated-reference-spatial-entities \
	hubmap-datasets

DATMIR = true

$(DATA_MIRROR_DIR)/reference-spatial-entities.jsonld:
	if [ $(DATMIR) = true ]; then wget -nc https://raw.githubusercontent.com/hubmapconsortium/hubmap-ontology/master/source_data/reference-spatial-entities.jsonld -O $@; fi
.PRECIOUS: $(DATA_MIRROR_DIR)/reference-spatial-entities.jsonld

$(DATA_MIRROR_DIR)/generated-reference-spatial-entities.jsonld:
	if [ $(DATMIR) = true ]; then wget -nc https://raw.githubusercontent.com/hubmapconsortium/hubmap-ontology/master/source_data/generated-reference-spatial-entities.jsonld -O $@; fi
.PRECIOUS: $(DATA_MIRROR_DIR)/generated-reference-spatial-entities.jsonld

$(DATA_MIRROR_DIR)/hubmap-datasets.jsonld:
	if [ $(DATMIR) = true ]; then wget -nc https://hubmap-link-api.herokuapp.com/hubmap-datasets?format=jsonld -O $@; fi
.PRECIOUS: $(DATA_MIRROR_DIR)/hubmap-datasets.jsonld


# ----------------------------------------
# Data modules
# ----------------------------------------

DATA_DIR = data

DATA = reference_spatial_entities specimen_spatial_entities specimen_dataset
DATA_FILES = $(patsubst %, $(DATA_DIR)/%.owl, $(DATA))

DAT = true

.PHONY: all_data
all_data: $(DATA_FILES)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Finish generating data files:)
	$(foreach n, $(DATA_FILES), $(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: - $(n)))


## GENERATE-DATA: reference_spatial_entities

.PHONY: check_spatial2ccf
check_spatial2ccf:
	@type spatial2ccf > /dev/null 2>&1 || (echo "ERROR: spatial2ccf is required, please visit https://github.com/hubmapconsortium/spatial2ccf to install"; exit 1)

.PHONY: check_specimen2ccf
check_specimen2ccf:
	@type specimen2ccf > /dev/null 2>&1 || (echo "ERROR: specimen2ccf is required, please visit https://github.com/hubmapconsortium/specimen2ccf to install"; exit 1)

$(DATA_DIR)/reference_spatial_entities.owl: check_spatial2ccf $(DATA_MIRROR_DIR)/reference-spatial-entities.jsonld $(DATA_MIRROR_DIR)/generated-reference-spatial-entities.jsonld
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(DAT) = true ]; then spatial2ccf $(DATA_MIRROR_DIR)/reference-spatial-entities.jsonld \
		$(DATA_MIRROR_DIR)/generated-reference-spatial-entities.jsonld \
		--ontology-iri $(ONTBASE)/$@ -o $@.tmp.owl && mv $@.tmp.owl $@.tmp.owl && \
		$(ROBOT) annotate --input $@.tmp.owl --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: $(DATA_DIR)/reference_spatial_entities.owl

$(DATA_DIR)/specimen_spatial_entities.owl: check_spatial2ccf $(DATA_MIRROR_DIR)/hubmap-datasets.jsonld
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(DAT) = true ]; then spatial2ccf $(DATA_MIRROR_DIR)/hubmap-datasets.jsonld \
		--ontology-iri $(ONTBASE)/$@ -o $@.tmp.owl && mv $@.tmp.owl $@.tmp.owl && \
		$(ROBOT) annotate --input $@.tmp.owl --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: $(DATA_DIR)/specimen_spatial_entities.owl

$(DATA_DIR)/specimen_dataset.owl: check_specimen2ccf $(DATA_MIRROR_DIR)/hubmap-datasets.jsonld
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: Generating $@)
	if [ $(DAT) = true ]; then specimen2ccf $(DATA_MIRROR_DIR)/hubmap-datasets.jsonld \
		--ontology-iri $(ONTBASE)/$@ -o $@.tmp.owl && mv $@.tmp.owl $@.tmp.owl && \
		$(ROBOT) annotate --input $@.tmp.owl --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: $(DATA_DIR)/specimen_dataset.owl


# ----------------------------------------
# Prepare the ontology components
# ----------------------------------------

.PHONY: prepare_ccf_bso
prepare_ccf_bso: $(ASCTB_FILES)

.PHONY: prepare_ccf_sco
prepare_ccf_sco: $(DATA_DIR)/specimen_dataset.owl

.PHONY: prepare_ccf_spo
prepare_ccf_spo: $(DATA_DIR)/reference_spatial_entities.owl $(DATA_DIR)/specimen_spatial_entities.owl

.PHONY: prepare_ccf
prepare_ccf: $(ASCTB_FILES) $(DATA_FILES)

# ----------------------------------------
# Create the releases
# ----------------------------------------

CCF_ARTEFACTS = $(CCF_BSO) $(CCF_SCO) $(CCF_SPO) $(CCF)
PRE_RELEASED_FILES = $(patsubst %, %.owl, $(CCF_ARTEFACTS))

.PHONY: release_ccf_bso
release_ccf_bso: $(CCF-BSO).owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating a release for the CCF Biological Structure (CCF-BSO) ontology)
	mv $^ $(RELEASEDIR)

.PHONY: release_ccf_sco
release_ccf_sco: $(CCF-SCO).owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating a release for the CCF Specimen (CCF-SCO) ontology)
	mv $^ $(RELEASEDIR)

.PHONY: release_ccf_spo
release_ccf_spo: $(CCF-SPO).owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating a release for the CCF Spatial (CCF-SPO) ontology)
	mv $^ $(RELEASEDIR)

.PHONY: release_only_ccf
release_only_ccf: $(CCF).owl
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating a release for the CCF ontology only)
	mv $^ $(RELEASEDIR)

.PHONY: release_ccf
release_ccf: $(PRE_RELEASED_FILES)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating a release for the CCF ontology, including all its modules)
	mv $^ $(RELEASEDIR)


# ----------------------------------------
# Create the ontology
# ----------------------------------------

.PHONY: ccf_bso
ccf_bso: $(ONT)-bso.owl

$(ONT)-bso.owl: $(CCF_BSO_SRC)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating CCF Biological Structure (CCF-BSO) ontology)
	$(ROBOT) merge --input $< \
		reason --reasoner ELK --equivalent-classes-allowed all --exclude-tautologies structural \
		relax \
		reduce -r ELK \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@
.PRECIOUS: $(ONT)-bso.owl

.PHONY: ccf_sco
ccf_sco: $(ONT)-sco.owl

$(ONT)-sco.owl: $(CCF_SCO_SRC)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating CCF Specimen (CCF-SCO) ontology)
	$(ROBOT) merge --input $< \
		reason --reasoner ELK --equivalent-classes-allowed all --exclude-tautologies structural \
		relax \
		reduce -r ELK \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@
.PRECIOUS: $(ONT)-sco.owl

.PHONY: ccf_spo
ccf_spo: $(ONT)-spo.owl

$(ONT)-spo.owl: $(CCF_SPO_SRC)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating CCF Spatial (CCF-SPO) ontology)
	$(ROBOT) merge --input $< \
		reason --reasoner ELK --equivalent-classes-allowed all --exclude-tautologies structural \
		relax \
		reduce -r ELK \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@
.PRECIOUS: $(ONT)-spo.owl

.PHONY: ccf
ccf: $(ONT)-bso.owl $(ONT)-sco.owl $(ONT)-spo.owl $(ONT).owl 

$(ONT).owl: $(CCF_SRC)
	$(info [$(shell date +%Y-%m-%d\ %H:%M:%S)] make: creating CCF ontology)
	$(ROBOT) merge --input $< \
		reason --reasoner ELK --equivalent-classes-allowed all --exclude-tautologies structural \
		relax \
		reduce -r ELK \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@
.PRECIOUS: $(ONT).owl


# ----------------------------------------
# Clean up
# ----------------------------------------

GENERATED_FILES = \
	$(COMPONENT_FILES) \
	$(EXTRACT_FILES) \
	$(DATA_FILES) \
	$(PRE_RELEASED_FILES) 

.PHONY: clean_all
clean_all:
	rm -f $(GENERATED_FILES)
