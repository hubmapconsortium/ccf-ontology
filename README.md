# Common Coordinate Framework Atlas ontology

More information can be found at https://bioportal.bioontology.org/ontologies/CCF

## Versions

### Stable release versions

~~The latest version of the ontology can always be found at https://bioportal.bioontology.org/ontologies/CCF~~

### Editors' version

Editors of this ontology should use the edit version that can be found at [src/ontology/ccf-edit.owl](src/ontology/ccf-edit.owl)

## Build

### Prerequisites

Users are required to install two programs to generate module ontologies from external data.

- [cedar2ccf](https://github.com/hubmapconsortium/cedar2ccf)
- [rui2ccf](https://github.com/hubmapconsortium/rui2ccf)

Please consult with each GitHub site for the installation and configuration manual.

### Commands

Users who wish to build the CCF ontology by themselves can clone this repository and execute the `make` commands.

```
$ git clone https://github.com/hubmapconsortium/ccf-ontology.git
$ cd ccf-ontology/src/ontology
$ make all_things
$ open ccf.owl
```

To skip re-downloading the required ontologies (bypassing mirror generation):
```
$ make MIR=false all_things -B
```

Some other useful flags to skip some steps in the `make` command:
```
IMP=false - bypass import ontology generation
IMP_LARGE=false - bypass large import ontology generation
TMP=false - bypass ontology generation from templates
DAT=false - bypass ontology generation from external data
```

## Contact

Please use this GitHub repository's [Issue tracker](https://github.com/hubmapconsortium/ccf-ontology/issues) to request new terms/classes or report errors or specific concerns related to the ontology.

## Acknowledgements

This ontology repository was created using the [ontology starter kit](https://github.com/INCATools/ontology-starter-kit)