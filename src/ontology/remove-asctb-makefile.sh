#!/bin/bash

# Parse the arguments
for ARGUMENT in "$@"
do
   KEY=$(echo $ARGUMENT | cut -f1 -d=)

   KEY_LENGTH=${#KEY}
   VALUE="${ARGUMENT:$KEY_LENGTH+1}"

   export "$KEY"="$VALUE"
done

# Standardized the input string to CamelCase
ORGAN_LABEL=$(echo $ORGAN | sed 's/.*/\L&/;s/[a-z]*/\u&/g' | tr -d '-' | tr -d '[:space:]') 

# Standardized the organ name for naming the output file to snake_case
ORGAN_NAME=$(echo $ORGAN_LABEL | sed 's/[[:upper:]]/_&/g;s/^_//' | tr '[:upper:]' '[:lower:]')

if [[ -f $(echo ccf.$ORGAN_LABEL.Makefile) ]]
then
	echo "Removing ccf.$ORGAN_LABEL.Makefile"
	rm -f ccf.$ORGAN_LABEL.Makefile
fi

if grep -Fq "include ccf.$ORGAN_LABEL.Makefile" ccf.Asctb.Makefile;
then
	echo "Removing '$ORGAN_LABEL' from ccf.Asctb.Makefile"
	sed -n "/include ccf.$ORGAN_LABEL.Makefile/!p" ccf.Asctb.Makefile > ccf.Asctb.tmp.Makefile
	mv ccf.Asctb.tmp.Makefile ccf.Asctb.Makefile
fi

if grep -Fq "\$(COMPONENTS_DIR)/asctb_$ORGAN_NAME.owl \\" ccf.AsctbList.Makefile;
then
	echo "Removing '$ORGAN_LABEL' from ccf.AsctbList.Makefile"
	sed -n "/\$(COMPONENTS_DIR)\/asctb_$ORGAN_NAME.owl/!p" ccf.AsctbList.Makefile > ccf.AsctbList.tmp.Makefile
	mv ccf.AsctbList.tmp.Makefile ccf.AsctbList.Makefile
fi