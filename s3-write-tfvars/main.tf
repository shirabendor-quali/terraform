provider "aws" {
  region = "eu-west-1"
}

resource "aws_s3_bucket_object" "object" {
  bucket  = "${var.BUCKET_NAME}"
  key     = "${var.SANDBOX_ID}.json"
  content = "{ \"Content\": \"${var.CONTENT}\"}"
  acl     = "bucket-owner-full-control"
}
