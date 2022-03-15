#!/bin/bash

./close_user_session.sh 49ed49e57438b2333a82b399144cc136 nick00000000622a241e25a1cac0

# This script uses jq, a JSON processor, to make the output easier to read. 
# To install jq, run: 
#  sudo dnf install jq
# see
# https://www.dmtf.org/sites/default/files/standards/documents/DSP2046_2017.0a.pdf
# BootSourceOverrideEnabled

SESSION_TOKEN=$1
SESSION_ID=$2
JSON_FILE=${0}.json

curl --verbose --insecure --silent \
  --request DELETE \
  --header "X-Auth-Token: $SESSION_TOKEN" \
  --header 'Content-Type: application/json' \
  https://bmc1/redfish/v1/SessionService/Sessions/$SESSION_ID
  > $JSON_FILE

echo
cat $JSON_FILE | jq .

