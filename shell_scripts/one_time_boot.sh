#!/bin/bash

# This script uses jq, a JSON processor, to make the output easier to read. 
# To install jq, run: 
#  sudo dnf install jq
# see
# https://www.dmtf.org/sites/default/files/standards/documents/DSP2046_2017.0a.pdf
# BootSourceOverrideEnabled

#set USER and PASS
source ./account
#
SERVICE=https://192.168.1.245
JSON_FILE=${0}.json

curl -v --insecure --silent \
  -X PATCH \
  -u $USER:$PASS \
  -H 'Content-Type: application/json' \
  --data '
  {
        "Boot": {
           "BootSourceOverrideTarget": "Cd", 
           "BootSourceOverrideEnabled": "Once", 
           "UefiTargetBootSourceOverride": null
        }
  }' \
  $SERVICE/redfish/v1/Systems/1 \
  > $JSON_FILE

echo
cat $JSON_FILE | jq .

