terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>4.0"            
        }
    }  
}

provider "aws" {
  region = var.aws_region
}

# allows using data attributes of current AWS account
data "aws_caller_identity" "current" {}

# Retrieve details of existing S3 bucket by name
data "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
}

# Random name suffix
resource "random_pet" "bucket_name" {
  length = 4
}

# Zip source code into zip file
data "archive_file" "app_hello_world_zip" {
  type = "zip"

  source_dir  = "${path.module}/hello-world"
  output_path = "${path.module}/hello-world.zip"
}

## Watch for changes in ZIP SHA - used as a watcher for updated in the app sources
resource "null_resource" "sha_change_checker" {
  triggers = {
    src_hash = "${data.archive_file.app_hello_world_zip.output_sha}"
  }

  provisioner "local-exec" {
    command = "echo Changes discovered in app code"
  }
}

# Upload app code archive from runner to S3 
resource "aws_s3_object" "hello_world_code_file" {
  bucket = data.aws_s3_bucket.bucket.id

  key    = "hello-world.zip"
  source = data.archive_file.app_hello_world_zip.output_path

  etag = filemd5(data.archive_file.app_hello_world_zip.output_path)
}

resource "aws_elastic_beanstalk_application" "application" {
  name = var.application_name
}

resource "aws_elastic_beanstalk_environment" "environment" {
  name                = var.environment_name
  application         = aws_elastic_beanstalk_application.application.name
  solution_stack_name = var.solution_stack_name

#   setting {
#     namespace = "aws:ec2:vpc"
#     name      = "VPCId"
#     value     = "vpc-xxxxxxxx"
#   }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "arn:aws:iam::046086677675:role/aws-elasticbeanstalk-ec2-role"
  }
 
}

resource "null_resource" "create_app_version" {
  depends_on = [aws_elastic_beanstalk_application.application]
  
  triggers = {
    app_name      = var.application_name
    version_label = "v1"
    s3_bucket     = var.bucket_name
    s3_key        = "hello-world.zip"
  }

  provisioner "local-exec" {
    command = <<EOT
      aws --region "eu-central-1" elasticbeanstalk create-application-version \
        --application-name ${var.application_name} \
        --version-label "v1" \
        --source-bundle S3Bucket=${var.bucket_name},S3Key="hello-world.zip"
    EOT
  }
}
