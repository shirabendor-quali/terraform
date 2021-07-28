variable "DOMAIN" {
  type = string
}

variable "HOST" {
  type = string
}

variable "SANDBOX_PUBLIC_ADDRESS" {
  type = string
}

provider "aws" {
  region = "eu-west-1"
  access_key = "AKIAXPBMMBHTE3OZS6IB"
  secret_key = "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"
}

data "aws_elb_hosted_zone_id" "main" {}

data "aws_route53_zone" "domain" {
  name         = var.DOMAIN
  private_zone = false
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = var.HOST
  type    = "A"
  alias {
    name                   = var.SANDBOX_PUBLIC_ADDRESS
    zone_id                = data.aws_elb_hosted_zone_id.main.id
    evaluate_target_health = true
  }
}
