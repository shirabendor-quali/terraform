#provider "aws" {
#  region = "eu-west-1"
#}

# comment 12345

resource "aws_s3_bucket_object" "object" {
  bucket  = "${var.BUCKET_NAME}"
  key     = "my-key-1111"
  content = "{ \"Content\": \"${var.CONTENT}\"}"
  acl     = "bucket-owner-full-control"
}

# this is an update
