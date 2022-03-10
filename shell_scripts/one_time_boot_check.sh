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

curl -v --insecure -u $USER:$PASS --silent \
  $SERVICE/redfish/v1/Systems/1 \
  > $JSON_FILE

echo
cat $JSON_FILE | jq .
echo
echo -n Boot
cat $JSON_FILE | jq .Boot
echo
echo -n BootSourceOverrideEnabled
cat $JSON_FILE | jq .Boot.BootSourceOverrideEnabled
echo
echo -n BootSourceOverrideTarget
cat $JSON_FILE | jq .Boot.BootSourceOverrideTarget

