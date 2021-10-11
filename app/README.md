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

Open the web browser (e.g., Chrome, Firefox, Safari) and type `http://localhost:3000`

