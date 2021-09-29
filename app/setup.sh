#!/bin/bash

TDB_DIR=.tdb

if [ -d "$TDB_DIR" ]; then rm -Rf $TDB_DIR; fi

echo "Reasoning the OWL ontology..."
robot reason --reasoner ELK --input ../ccf.owl --exclude-tautologies structural --output ccf-reasoned.owl

echo "Creating Jena TDB datasets..."
robot query --input ccf-reasoned.owl --create-tdb true

echo "Finished."
rm ccf-reasoned.owl