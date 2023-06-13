variable "input_value" {
  type        = string
  description = "Input value for the Terraform configuration"
  default     = "default"
}

resource "null_resource" "example" {
  triggers = {
    input_value = var.input_value
  }

  provisioner "local-exec" {
    command = <<EOT
if [[ "${var.input_value}" == "shira" ]]; then
  echo "Error: Input value is 'shira'. Failing apply phase."
  exit 1
fi
EOT
  }
}
