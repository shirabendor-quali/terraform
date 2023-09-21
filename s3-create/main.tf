terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">4.0.0"
    }
  }
}

# update dbs
provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.name
}

# new update 12345
