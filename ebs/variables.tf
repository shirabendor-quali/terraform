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

variable "lambda_iam_role" {
  description = "Name of IAM role to execute serverless function."

  type    = string
  default = "torque-dev"
}

variable "application_name" {
  description = "The name of the Elastic Beanstalk application."
}

variable "environment_name" {
  description = "The name of the Elastic Beanstalk environment."
}

variable "solution_stack_name" {
  description = "The name of the solution stack to use for the environment."
}