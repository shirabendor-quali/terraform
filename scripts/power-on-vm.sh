# Obtain the federated token
federated_token=$(cat $AZURE_FEDERATED_TOKEN_FILE)
# Use the federated token to authenticate your API call
curl -X POST -H "Authorization: Bearer $federated_token" -H "Content-Type: application/json" https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/start?api-version=2023-09-01
