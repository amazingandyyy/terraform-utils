#!/bin/bash

# Usage: terraform-imports-generate run-iD5A1SqP8njbCc2C-plan-log.txt
if [ $# -ne 1 ]; then
  echo "Usage: $0 <plan-log.txt>"
  exit 1
fi

# File containing the list of Terraform state entries
SRC_FILE=$(realpath "$1")

# Prepare the output file by ensuring its directory exists
workingDir=$(dirname "$2")

pushd "$workingDir" > /dev/null
echo "Extracting created resources from $SRC_FILE"
# cat $SRC_FILE | grep '^#' | grep -v '^data.' | grep -v '.data' | grep -v '.metadata.' | sed 's/://g' | sed 's/#//g' | sort > terraform-plan-list.txt
cat "$SRC_FILE" | grep '#' | grep "will be created$" | sed 's/://g' | sed 's/#//g' | grep -v '^data\.' | grep -v '\.data\.' | grep -v '\.metadata\.' | sed 's/\x1b\[[0-9;]*m//g' | sed 's/^[[:space:]]*//;s/[[:space:]]*will be created$//' > terraform-plan-created.txt
popd > /dev/null
