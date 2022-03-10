# Common Coordinate Framework Atlas ontology

More information can be found at https://bioportal.bioontology.org/ontologies/CCF

## Ontology releases

Please check the Releases panel on the side bar to get the latest version.

## Editing the ontologies

Editors of the CCF ontology should use the edit version that can be found at [src/ontology/ccf-edit.owl](src/ontology/ccf-edit.owl) for the global CCF ontology.

The other three ontology modules are located in the same folder:
* CCF Biological Structure Ontology ([src/ontology/ccf-bso-edit.owl](src/ontology/ccf-bso-edit.owl))
* CCF Specimen Ontology ([src/ontology/ccf-sco-edit.owl](src/ontology/ccf-sco-edit.owl))
* CCF Spatial Ontology ([src/ontology/ccf-spo-edit.owl](src/ontology/ccf-spo-edit.owl))

## Build

### Prerequisites

Users are required to have all these programs installed in their local computer:

- Java 8
- [asctb2ccf](https://github.com/hubmapconsortium/asctb2ccf)
- [specimen2ccf](https://github.com/hubmapconsortium/specimen2ccf)
- [spatial2ccf](https://github.com/hubmapconsortium/spatial2ccf)

Please look at each GitHub repository for the installation and configuration instructions.

### Commands

Use the commands below to build the CCF ontology from scratch.

```
$ git clone https://github.com/hubmapconsortium/ccf-ontology.git
$ cd ccf-ontology/src/ontology
$ make -s prepare_all
$ make -s build_all
$ open ccf.owl
```

The command below is to avoid re-downloading the some big files (bypassing the data mirror generation).
```
$ make MIR=false DATMIR=false prepare_ccf -B
```

Some other useful flags to skip some steps in the `make` command:
```
MIR=false - bypass dowload source ontologies
DATMIR=false - bypass download source files
IMP=false - bypass import ontology generation
IMP_LARGE=false - bypass large import ontology generation
DAT=false - bypass ontology generation from external data
```

The command below is to create a release of CCF ontology, including all the three modules.
```
$ make -s release_all
```

## Contact

Please use this GitHub repository's [Issue tracker](https://github.com/hubmapconsortium/ccf-ontology/issues) to request new terms/classes or report errors or specific concerns related to the ontology.

## Acknowledgements

This ontology repository was created using the [ontology starter kit](https://github.com/INCATools/ontology-starter-kit)