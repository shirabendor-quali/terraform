provider "aws" {
  region = "eu-west-1"
  access_key = var.AWS_ACCESS_KEY == "none" ? "" : var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_ACCESS == "none" ? "" : var.AWS_SECRET_ACCESS
}

locals {
  common_tags = {
    environment  = "tintin"
    name = "tomer"
  }
}

resource "aws_security_group" "my_sg" {
  name        = "${var.SG_NAME}"
  description = "SG created from tomer.v service"

  tags = {
    Name = "test",
    "tomer test" = "good test"
  }
}
