#!/bin/bash

# ./use_user_session.sh  c90fea5fc242c1ef43f1fa02382aa174  1

# This script uses jq, a JSON processor, to make the output easier to read. 
# To install jq, run: 
#  sudo dnf install jq
# see
# https://www.dmtf.org/sites/default/files/standards/documents/DSP2046_2017.0a.pdf
# BootSourceOverrideEnabled

SESSION_TOKEN=$1
SESSION_ID=$2
SERVICE=https://192.168.1.245
JSON_FILE=${0}.json

curl --verbose --insecure --silent \
  --request DELETE \
  --header "X-Auth-Token: $SESSION_TOKEN" \
  --header 'Content-Type: application/json' \
  $SERVICE/redfish/v1/SessionService/Sessions/$SESSION_ID
  > $JSON_FILE

echo
cat $JSON_FILE | jq .

