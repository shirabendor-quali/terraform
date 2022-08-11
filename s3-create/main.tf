provider "aws" {
  region = "eu-west-1"
}

resource "aws_s3_bucket" "this" {
    bucket = "${var.bucket_name}" 
    acl = "${var.acl_value}"   
}
