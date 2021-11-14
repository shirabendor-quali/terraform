#!/bin/bash

StorageAccount=$1
Container=$2
BlobName=$3
ResourceGroup=$4

# get access token
token_response=$(curl -s 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fmanagement.azure.com%2F&client_id='$ARM_CLIENT_ID -H Metadata:true)
token=$(echo $token_response | grep -oP '(?<="access_token":")[^"]*')

# generate sas
end=`date -u -d "30 minutes" '+%Y-%m-%dT%H:%MZ'`
sas_response=$(curl -s https://management.azure.com/subscriptions/$ARM_SUBSCRIPTION_ID/resourceGroups/$ResourceGroup/providers/Microsoft.Storage/storageAccounts/$StorageAccount/listServiceSas/?api-version=2017-06-01 -X POST -d "{\"canonicalizedResource\":\"/blob/$StorageAccount/$Container/$BlobName\",\"signedResource\":\"b\",\"signedPermission\":\"r\",\"signedProtocol\":\"https\",\"signedExpiry\":\"$end\"}" -H "Authorization: Bearer $token")
# the response has json format of {"serviceSasToken":"sas"}
echo $sas_response