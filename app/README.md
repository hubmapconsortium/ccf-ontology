# Cell Type Finder

## Installation

### Pre-requisites

Please install the following supported software:

1. [ROBOT](http://robot.obolibrary.org/)
2. [NodeJS](https://nodejs.org/en/)

### Setup

Build the RDF graph database by executing the command below in the `app/` directory:

```bash
$ robot query --input ../ccf.owl --create-tdb true
```

This command will create a hidden directory called `.tdb`

### Run the service

Run the NodeJS service using the command below:

```bash
$ node index.js
```

## Usage

Open the web browser (e.g., Chrome, Firefox, Safari) and type `http://localhost:3000`.

<img width="1202" alt="Screen Shot 2021-10-11 at 2 07 58 PM" src="https://user-images.githubusercontent.com/5062950/136855796-14e90a7f-7e6b-49b1-8d77-c85cdab3cea2.png" style="border:1px solid #000000;">

You begin to add a set of biomarker symbols (separated by commas) in the given text area and click the "Find" button. Alternatively, you can use the given examples in the drop-down selector. The application will search a cell type that can be identified by the given biomarkers and its organ location. When it is available, the application will draw the organ's 3D model through the BabylonJS embedded renderer.
