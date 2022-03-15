#!/bin/bash
#
#     "ResetType@Redfish.AllowableValues": [
#        "On",
#        "ForceOff",
#        "GracefulShutdown",
#        "ForceRestart",
#        "Nmi",
#        "PushPowerButton",
#        "GracefulRestart"
#     ],
#
# This script uses jq, a JSON processor, to make the output easier to read. 
# To install jq, run: 
#  sudo dnf install jq

#set USER and PASS
source ./account
#
JSON_FILE=${0}.json

curl -v --insecure --silent \
  -X POST \
  -u $USER:$PASS \
  -H 'Content-Type: application/json' \
  --data '{ "ResetType": "GracefulRestart" }' \
  https://bmc1/redfish/v1/Systems/1/Actions/ComputerSystem.Reset \
  > $JSON_FILE

echo
cat $JSON_FILE | jq .

