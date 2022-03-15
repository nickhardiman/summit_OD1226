#!/bin/bash

# ./use_user_session.sh  c90fea5fc242c1ef43f1fa02382aa174

# This script uses jq, a JSON processor, to make the output easier to read. 
# To install jq, run: 
#  sudo dnf install jq
# see
# https://www.dmtf.org/sites/default/files/standards/documents/DSP2046_2017.0a.pdf
# BootSourceOverrideEnabled

TOKEN=$1
JSON_FILE=${0}.json

curl -v --insecure --silent \
  --request GET \
  --header "X-Auth-Token: $1" \
  --header 'Content-Type: application/json' \
  https://bmc1/redfish/v1/Systems/1 \
  > $JSON_FILE

echo
cat $JSON_FILE | jq .

