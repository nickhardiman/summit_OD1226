#!/bin/bash

# "Manufacturer" is a property in the "ComputerSystems" schema. 
# All schemas are described in this document. 
# DSP2046 Redfish Resource and Schema Guide
# https://www.dmtf.org/sites/default/files/standards/documents/DSP2046_2021.4.pdf

# jq
# https://stedolan.github.io/jq/
# This script uses jq, a JSON processor, to make the output easier to read. 
# To install jq, run: 
#  sudo dnf install jq


#set USER and PASS
source ./account
#

# OASIS OData
# https://www.odata.org/getting-started/basic-tutorial/
# use ODATA "select" to display manufacturer JSON
# Single quotes around the URI stop bash treating "$select" as a variable.
#
curl -v --insecure --silent \
  -X GET \
  -u $USER:$PASS \
  -H 'Content-Type: application/json' \
  --data '{}' \
  'https://bmc1/redfish/v1/Systems/1?$select=Manufacturer' \
  > ${0}-select.json
#
# Use jq to make JSON readable.
echo
echo "Manufacturer JSON:  "
cat ${0}-select.json | jq .

curl --insecure --silent \
  -X GET \
  -u $USER:$PASS \
  -H 'Content-Type: application/json' \
  --data '{}' \
  https://bmc1/redfish/v1/Systems/1 \
  > ${0}-all.json
#
echo
echo -n "Manufacturer value:  "
cat ${0}-all.json | jq .Manufacturer

