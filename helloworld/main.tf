variable "input_value" {
  type        = number
  description = "Input value for the Terraform configuration"
  default     = 1
}

resource "null_resource" "example" {
  triggers = {
    input_value = var.input_value
  }

  provisioner "local-exec" {
    command = <<EOT
if [[ ${var.input_value} -eq 2 ]]; then
  echo "Error: Input value is 2. Failing apply phase."
  exit 1
fi
EOT
  }
}
