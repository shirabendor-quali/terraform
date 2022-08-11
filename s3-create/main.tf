provider "aws" {
  region = "eu-west-1"
}

resource "aws_s3_bucket" "this" {
    bucket = "${var.BUCKET_NAME}" 
    acl = "private"  
}
