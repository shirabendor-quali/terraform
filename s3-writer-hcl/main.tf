provider "aws" {
  region     = "eu-west-1"
  access_key = var.AWS_ACCESS_KEY == "none" ? "" : var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_ACCESS == "none" ? "" : var.AWS_SECRET_ACCESS
}


locals {
  object = <<-EOT
SERVER_NAME:${var.SERVER_NAME}
SERVER_VERSION:${var.SERVER_VERSION}
OUTPUTS_PUBLISHER_NUMBER:${var.OUTPUTS_PUBLISHER_NUMBER}
OUTPUTS_PUBLISHER_FRACTION:${var.OUTPUTS_PUBLISHER_FRACTION}
OUTPUTS_PUBLISHER_BOOL:${var.OUTPUTS_PUBLISHER_BOOL}
TF_INPUT_STRING:${var.TF_INPUT_STRING}
TF_INPUT_NUMBER:${var.TF_INPUT_NUMBER}
TF_INPUT_LIST:${var.TF_INPUT_LIST[0]}
TF_INPUT_MAP:${var.TF_INPUT_MAP["key1"]}
TF_INPUT_TUPLE:${var.TF_INPUT_TUPLE[0]["lmkey1"]}
TF_INPUT_OBJECT_STR:${var.TF_INPUT_OBJECT.symbol}
TF_INPUT_OBJECT_ELM:${var.TF_INPUT_OBJECT.levels[1]}
LITERAL_PARAMETER:${var.LITERAL_PARAMETER}
AWS_SSM_PARAMETER:${var.AWS_SSM_PARAMETER}
EOT
}

resource "local_file" "object" {
  filename = "object-output"
  content = local.object
}

locals {
  output_object = {symbol = "GRVI", price = 1.2, levels = [1, 1.1, 1.4]}
  output_tuple =  [{key1 = "out-val1", key2 = "out-val2"}, "out-string", 6.7]
}

