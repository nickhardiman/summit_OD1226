#!/bin/bash

# https://developer.hpe.com/blog/managing-ilo-sessions-with-redfish/

# This script uses jq, a JSON processor, to make the output easier to read. 
# To install jq, run: 
#  sudo dnf install jq

#set USER and PASS
source ./account
#
SERVICE=https://192.168.1.245
JSON_FILE=${0}.json

curl -v --insecure --silent \
  --request POST \
  --header 'OData-Version: 4.0' \
  --header 'Content-Type: application/json' \
  --data '{
    "UserName": "nick",
    "Password": "redhatter"
  }' \
  $SERVICE/redfish/v1/SessionService/Sessions \
  > $JSON_FILE

echo
cat $JSON_FILE | jq .

