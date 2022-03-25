#!/bin/bash

TDB_DIR=.tdb
CCF_SOURCE=ccf.owl

if [ -d "$TDB_DIR" ]; then rm -Rf $TDB_DIR; fi

echo -ne "Reasoning <$CCF_SOURCE> ontology..."\\r
robot reason --reasoner ELK --input ../$CCF_SOURCE --exclude-tautologies structural --output ccf-reasoned.owl
echo "Reasoning <$CCF_SOURCE> ontology... done."

echo -ne "Creating Jena TDB datasets..."\\r
robot query --input ccf-reasoned.owl --create-tdb true
echo "Creating Jena TDB datasets... done."

echo -ne "Creating marker dictionary..."\\r
robot query --tdb-directory ./.tdb --keep-tdb-mappings true --query resources/get_marker_list.sparql /tmp/marker-list.csv &&\
csvjson /tmp/marker-list.csv | jq -s '.[] | map({(.label): .entity}) | add' > /tmp/marker-dictionary.json && 
sed $'/{{marker_dictionary}}/{ r /tmp/marker-dictionary.json\nd; }' resources/lookup.js.template > lookup.js
echo "Creating marker dictionary... done."
echo

# Cleaning up
rm ccf-reasoned.owl
rm /tmp/marker-list.csv
rm /tmp/marker-dictionary.json

node index.js
open "http://localhost:3000"
