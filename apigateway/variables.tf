# Input variable definitions

variable "aws_region" {
  description = "AWS region for all resources."

  type    = string
  default = "eu-central-1"
}

variable "apis" {
  type    = object({url: string, path : string})
  #default = { "URL" : "https://lambda-test-shira.s3.eu-central-1.amazonaws.com/hello-world.zip", "Path": "GET /hello" }
  default = { url : "https://ycjqiojqxzdjl4eiu2ifrylasa0xkprb.lambda-url.eu-central-1.on.aws", path : "GET /hello" }
}

variable "stage" {
  type    = string
  default = "dev"
}