#!/bin/bash

# get access token
token_response=$(curl -s 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fmanagement.azure.com%2F&client_id='$AZURE_CLIENT_ID -H Metadata:true)
token=$(echo $token_response | grep -oP '(?<="access_token":")[^"]*')
echo "token"
echo $token
echo "client1"
echo $AZURE_CLIENT_ID
echo "client2"
echo $ARM_CLIENT_ID
curl -X POST -H "Authorization: Bearer $token" -H "Content-Type: application/json" --header "Content-Length: 0" https://management.azure.com/subscriptions/$ARM_SUBSCRIPTION_ID/resourceGroups/$1/providers/Microsoft.Compute/virtualMachines/$2/start?api-version=2023-09-01

# generate sas
#end=`date -u -d "30 minutes" '+%Y-%m-%dT%H:%MZ'`
#sas_response=$(curl -s https://management.azure.com/subscriptions/$ARM_SUBSCRIPTION_ID/resourceGroups/$ResourceGroup/providers/Microsoft.Storage/storageAccounts/$StorageAccount/listServiceSas/?api-version=2017-06-01 -X POST -d "{\"canonicalizedResource\":\"/blob/$StorageAccount/$Container/$BlobName\",\"signedResource\":\"b\",\"signedPermission\":\"r\",\"signedProtocol\":\"https\",\"signedExpiry\":\"$end\"}" -H "Authorization: Bearer $token")
# the response has json format of {"serviceSasToken":"sas"}
#echo $sas_response

#export ACCESS_TOKEN=$(curl -H "Metadata: true" "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://management.azure.com/" --header "Content-Length: 0" | jq -r .access_token)

# Obtain the federated token
#federated_token=$(cat $AZURE_FEDERATED_TOKEN_FILE)
#echo $federated_token
#echo $ARM_SUBSCRIPTION_ID
# Use the federated token to authenticate your API call
#curl -X POST -H "Authorization: Bearer $ACCESS_TOKEN" -H "Content-Type: application/json" --header "Content-Length: 0" https://management.azure.com/subscriptions/$ARM_SUBSCRIPTION_ID/resourceGroups/$1/providers/Microsoft.Compute/virtualMachines/$2/start?api-version=2023-09-01 

