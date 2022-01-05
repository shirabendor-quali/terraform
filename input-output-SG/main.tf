provider "aws" {
  region = "eu-west-1"
}

resource "aws_security_group" "my_sg" {
  name        = "${var.INPUT_1}"
  description = "SG created from CI test service"

  tags = {
    Name = "${var.INPUT_1}"
  }
}

output "OUTPUT_1" {
  value = "${aws_security_group.my_sg.arn}"
}
