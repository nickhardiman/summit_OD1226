#!/bin/bash

# https://www.dmtf.org/sites/default/files/standards/documents/DSP0268_2021.4.pdf
# 6.122 VirtualMedia

# This script uses jq, a JSON processor, to make the output easier to read. 
# To install jq, run: 
#  sudo dnf install jq

#set USER and PASS
source ./account
#
JSON_FILE=${0}.json

# test with a downloaded image
#    "Image": "http://repo1/rhel-server-7.9-x86_64-boot.iso",
#    "Image": "http://repo1/rhel-8.5-x86_64-boot.iso",
# test with a customized image
#    "Image": "http://repo1/rhel7_test.iso",
#    "Image": "http://repo1/rhel8_test.iso",
# don't use FQDN, DNS is not set up yet. 
#    "Image": "http://repo1.lab.example.com/rhel-8.5-x86_64-boot.iso",

curl -v --insecure --silent \
  -X POST \
  -u $USER:$PASS \
  -H 'Content-Type: application/json' \
  --data '{
    "Image": "http://repo1/rhel7_test.iso",
    "Inserted": true,
    "WriteProtected": true
  }' \
  https://bmc1/redfish/v1/Managers/1/VirtualMedia/2/Actions/VirtualMedia.InsertMedia \
  > $JSON_FILE

echo
cat $JSON_FILE | jq .

