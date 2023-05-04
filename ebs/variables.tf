# Input variable definitions

variable "aws_region" {
  description = "AWS region for all resources."

  type    = string
  default = "eu-central-1"
}

variable "bucket_name" {
  description = "Existing AWS Bucket to store code artifacts."

  type    = string
  default = "torque-app-artifacts-demo"
}

variable "application_name" {
  description = "The name of the Elastic Beanstalk application."
  default = "torque-demo-application-name"
}

variable "environment_name" {
  description = "The name of the Elastic Beanstalk environment."
  default = "torque-demo-environment-name"
}

variable "solution_stack_name" {
  description = "The name of the solution stack to use for the environment."
  default = "64bit Amazon Linux 2 v3.5.2 running Python 3.7"
}

variable "vpc_id" {
  default = "vpc-02f6250509ffd0dcf"
}

variable "instance_profile" {
   default = "arn:aws:iam::046086677675:instance-profile/InstanceProfilePowerUser"
}

variable "subnet" {
   default = "subnet-08fbd2c14ebda7831"
}