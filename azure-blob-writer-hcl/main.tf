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
SERVER_NAME:${var.SERVER_NAME}
SERVER_VERSION:${var.SERVER_VERSION}
OUTPUTS_PUBLISHER_NO_HCL:${var.OUTPUTS_PUBLISHER_NO_HCL}
OUTPUTS_PUBLISHER_NUMBER:${var.OUTPUTS_PUBLISHER_NUMBER}
OUTPUTS_PUBLISHER_FRACTION:${var.OUTPUTS_PUBLISHER_FRACTION}
OUTPUTS_PUBLISHER_BOOL:${var.OUTPUTS_PUBLISHER_BOOL}
OUTPUTS_PUBLISHER_TUPLE_KEY2:${var.OUTPUTS_PUBLISHER_TUPLE[0]["key2"]}
OUTPUTS_PUBLISHER_TUPLE_NUM:${var.OUTPUTS_PUBLISHER_TUPLE[2]}
OUTPUTS_PUBLISHER_OBJECT_ELM:${var.OUTPUTS_PUBLISHER_OBJECT.symbol}
TF_INPUT_STRING:${var.TF_INPUT_STRING}
TF_INPUT_NUMBER:${var.TF_INPUT_NUMBER}
TF_INPUT_LIST:${var.TF_INPUT_LIST[0]}
TF_INPUT_MAP:${var.TF_INPUT_MAP["key1"]}
TF_INPUT_TUPLE:${var.TF_INPUT_TUPLE[0]["lmkey1"]}
TF_INPUT_OBJECT_STR:${var.TF_INPUT_OBJECT.symbol}
TF_INPUT_OBJECT_ELM:${var.TF_INPUT_OBJECT.levels[1]}
PUBLIC_ADDRESS_NEW:${var.PUBLIC_ADDRESS_NEW}
SANDBOX_ID_NEW:${var.SANDBOX_ID_NEW}
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
