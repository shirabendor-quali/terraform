provider "aws" {
  region = "eu-west-1"
}

resource "aws_security_group" "my_sg" {
  name        = "${var.SG_NAME}"
  description = "SG created from CI test service"

  tags = {
    Name = "${var.SG_NAME}"
  }
}

output "security_group_arn" {
  value = "${aws_security_group.my_sg.arn}"
}
