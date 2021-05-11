provider "azurerm" {
  version = "=1.35.0"   # the earliest version we support for msi
}

provider "external" {
  version = "=1.2"
}

resource "azurerm_storage_blob" "blob_to_create" {
  name                   = "${var.blob_name}"
  storage_account_name   = "${var.storage_account_name}"
  storage_container_name = "${var.storage_container_name}"
  type                   = "Block"
  source_content         = <<EOF
USER_CONTENT:${var.USER_CONTENT}
SERVER_NAME:${var.SERVER_NAME}
SERVER_VERSION:${var.SERVER_VERSION}
OUTPUTS_PUBLISHER_STR_OLD:${var.OUTPUTS_PUBLISHER_STR_OLD}
OUTPUTS_PUBLISHER_STR:${var.OUTPUTS_PUBLISHER_STR}
OUTPUTS_PUBLISHER_NUMBER:${var.OUTPUTS_PUBLISHER_NUMBER}
OUTPUTS_PUBLISHER_FRACTION:${var.OUTPUTS_PUBLISHER_FRACTION}
OUTPUTS_PUBLISHER_BOOL:${var.OUTPUTS_PUBLISHER_BOOL}
OUTPUTS_PUBLISHER_SPECIAL_CHARS_STR:${var.OUTPUTS_PUBLISHER_SPECIAL_CHARS_STR}
VIRTUAL_NETWORK_ID_NEW:${var.VIRTUAL_NETWORK_ID_NEW}
VIRTUAL_NETWORK_ID:${var.VIRTUAL_NETWORK_ID}
PUBLIC_ADDRESS_NEW:${var.PUBLIC_ADDRESS_NEW}
PUBLIC_ADDRESS:${var.PUBLIC_ADDRESS}
PUBLIC_ADDRESS_OLD:${var.PUBLIC_ADDRESS_OLD}
SANDBOX_ID_NEW:${var.SANDBOX_ID_NEW}
SANDBOX_ID:${var.SANDBOX_ID}
SANDBOX_ID_OLD:${var.SANDBOX_ID_OLD}
OUTPUTS:${var.OUTPUTS}
ALL_IN_ONE:${var.ALL_IN_ONE}
LITERAL_PARAMETER:${var.LITERAL_PARAMETER}
EOF
}

data "external" "generate_sas" {
  program = [
    "bash",
    "generate_sas.sh", 
    "${azurerm_storage_blob.blob_to_create.storage_account_name}",
    "${azurerm_storage_blob.blob_to_create.storage_container_name}", 
    "${azurerm_storage_blob.blob_to_create.name}",
    "${var.storage_account_resource_group}"
  ]
  # note: this is terraform 0.12 syntax
  depends_on = [azurerm_storage_blob.blob_to_create]  # adding a dependency so it won't be executed at the plan phase (as part of refreshing state)
}
