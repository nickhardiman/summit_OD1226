#!/bin/bash

# This script uses jq, a JSON processor, to make the output easier to read. 
# To install jq, run: 
#  sudo dnf install jq

#set USER and PASS
source ./account
#
SERVICE=https://192.168.1.245
JSON_FILE=${0}.json

curl -v --insecure --silent \
  -X GET \
  -u $USER:$PASS \
  -H 'Content-Type: application/json' \
  --data '{}' \
  $SERVICE/redfish/v1/Managers/1/VirtualMedia/2 \
  > $JSON_FILE

echo
cat $JSON_FILE | jq .
echo
echo -n "Image  "
cat $JSON_FILE | jq .Image

