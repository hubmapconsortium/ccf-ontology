# Standard Operating Procedure (SOP) Document for Ontology Editor

## A) Downloading the CCF ontology development environment

### Pre-requisites

Editors are required to have Git ([How to install](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)) to be able to download the development environment.

### Running the commands

Follow the steps below to download and setup the CCF ontology development environment:

1. Run the `git clone` command in the command terminal.
   
   ```
   $ git clone https://github.com/hubmapconsortium/ccf-ontology.git
   ```

2. Switch to `ccf-ontology` directory.
   
   ```
   $ cd ccf-ontology
   ```

3. Make sure you are in the `develop` environment by checking the command output.
   
   ```
   $ git branch --show-current
   develop
   ```

## B) Adding new Organ Reference to CCF ontology

### Pre-requisites

Editors have done the step for "Downloading the CCF ontology development environment".

### Running the commands

Make sure you are in the `develop` environment before running the commands below.

```
$ git branch --show-current
develop
```

If you are not in the `develop` environment, see "Switch to develop environment" section to solve the problem.

Follow the steps below to add a new organ reference to CCF ontology:

1. Go to `ccf-ontology` directory.

2. Navigate to the `src/ontology` directory
   
   ```
   $ cd src/ontology
   ```

3. Run the script to create automatically the Makefile. Fill out the `ORGAN` parameter with a proper organ name and the `GSHEET_URL` parameter with the ASCT+B table URL on Google Sheets (simply copy-and-paste the link from opening the table).
   
   ```
   $ ./create-asctb-makefile.sh ORGAN="[organ name]" GSHEET_URL="[ASCT+B Table URL]"
   ```

Some examples for the command:

* Adding the kidney organ
  
  ```
  ./create-asctb-makefile.sh ORGAN="kidney" GSHEET_URL="https://docs.google.com/spreadsheets/d/1PgjYp4MEWANfbxGIxFsJ9vkfEU90MP-v3p5oVlH8U-E/edit#gid=949267305"
  ```

* Adding the large intestine organ
  
  ```
  ./create-asctb-makefile.sh ORGAN="large intestine" GSHEET_URL="https://docs.google.com/spreadsheets/d/1vU6mQmnzAAxctbNYPoFxJ8NvbUql8pbipsGdt7YCOQQ/edit#gid=2043181688"
  ```

## C) Updating existing Organ Reference on CCF ontology

### Pre-requisites

Editors have done the step for "Downloading the CCF ontology development environment".

### Running the commands

Make sure you are in the `develop` environment before running the commands below.

```
$ git branch --show-current
develop
```

If you are not in the `develop` environment, see "Switch to develop environment" section to solve the problem.

Follow the steps below to upadate and existing organ reference on CCF ontology:

1. Go to `ccf-ontology` directory.

2. Navigate to the `src/ontology` directory
   
   ```
   $ cd src/ontology
   ```

3. Run the script to remove the current Makefile for the organ. Fill out the `ORGAN` argument with a proper organ name
   
   ```
   $ ./remove-asctb-makefile.sh ORGAN="[organ name]"
   ```

4. Run the script to recreate the new Makefile. Fill out both the `ORGAN` and `GSHEET_URL` parameters.
   
   ```
   $ ./create-asctb-makefile.sh ORGAN="[organ name]" GSHEET_URL="[New ASCT+B Table URL]"
   ```

## D) Building CCF ontology

### Pre-requisites

Editors are required to have all these programs installed in their computer:

1. Linux or Mac operating systems
2. OBO ROBOT tool ([How to install](https://robot.obolibrary.org/))
3. ASCT+B-to-CCF tool ([How to install](https://github.com/hubmapconsortium/asctb2ccf/blob/master/README.md))
4. Spatial-to-CCF tool ([How to install](https://github.com/hubmapconsortium/spatial2ccf/blob/main/README.md))
5. Specimen-to-CCF tool ([How to install](https://github.com/hubmapconsortium/specimen2ccf/blob/master/README.md))

Editors have done the step for "Downloading the CCF ontology development environment".

### Running the commands

Make sure you are in the `develop` environment before running the commands below.

```
$ git branch --show-current
develop
```

If you are not in the `develop` environment, see "Switch to develop environment" section to solve the problem.

Follow the steps below to build the CCF ontology:

1. Go to `ccf-ontology` directory.

2. Navigate to the `src/ontology` directory
   
   ```
   $ cd src/ontology
   ```

3. Run the command to generate the component modules. Enter the `[version number]` argument accordingly. The `-s` flag argument is to supress the prepare messages.
   
   ```
   $ make -s prepare_all VERSION=[version number]
   ```

4. Run the command to build the CCF ontology.
   
   ```
   $ make -s build_all VERSION=[version number]
   ```

The `build_all` command will ouput five ontology files as following:

* CCF Biological Structure Ontology - **ccf-bso.owl**.
* CCF Specimen Ontology - **ccf-sco.owl**.
* CCF Spatial Ontology - **ccf-spo.owl**.
* CCF Ontology (complete version) - **ccf.owl**.
* CCF-Slim Ontology (does not include the RUI datasets) - **ccf-slim.owl**.

## E) Releasing CCF ontology

### Pre-requisites

Editors are required to have all the programs that are found in the "Building CCF ontology" section.

### Running the Commands

Before running the commands to release the CCF ontology, it is important to follow the steps in the "Building CCF ontology" section first.

Follow the steps below to make a new release of the CCF ontology:

Run the command to release the ontologies.  Enter the `[version number]` argument accordingly. The `-s` argument is to supress the release messages.

```
$ make -s release_all VERSION=[version number]
```

The `release_all` command will move all the output ontology files from the `build_all` command to the `ccf-ontology` root directory.

Once you are ready to release the ontologies, run these following Git commands to materialize the changes:

1. Commit the changes on Git. Replace the `[version number]` placeholder with the proper versioning number, e.g., "2.0.1", "2.1.0", 2.1.1", etc.
   
   ```
   $ git commit . -m "Releasing [version number]."
   $ git tag "[version number]"
   $ git push
   ```
Up to this point, the ontology is still in the development environment and is not yet officially released. To make an official release, perform these steps below:

2. Run the Git command to switch to the `main` environment
   
   ```
   $ git checkout main
   ```

3. Bring all the ontology files from the development environment to the main environment by merging the changes.
   
   ```
   $ git merge develop
   ```

4. Push the changes to the GitHub repository to make an official release.
   ```
   $ git push
   ```

5. Switch back to the development environment to prepare the next cycle of development.
   
   ```
   $ git checkout develop
   ```

## Trobleshooting

### Switch to develop environment

On the terminal, run the command:

```
$ git checkout develop
```

### Avoid re-downloading reference ontologies

Add this parameter `MIR=false` when executing the make command, for example:

```
$ make -s prepare_all MIR=false
```