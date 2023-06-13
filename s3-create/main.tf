terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">4.0.0"
    }
  }
}

provider "aws" {
  #region = var.region
  region = "us-east-1"
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.name
}

# this is an update
