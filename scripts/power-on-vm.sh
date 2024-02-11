export ACCESS_TOKEN=$(curl -H "Metadata: true" "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://management.azure.com/" --header "Content-Length: 0" | jq -r .access_token)

# Obtain the federated token
#federated_token=$(cat $AZURE_FEDERATED_TOKEN_FILE)
# Use the federated token to authenticate your API call
curl -X POST -H "Authorization: Bearer $ACCESS_TOKEN" -H "Content-Type: application/json" https://management.azure.com/subscriptions/$ARM_SUBSCRIPTION_ID/resourceGroups/$1/providers/Microsoft.Compute/virtualMachines/$2/start?api-version=2023-09-01
