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
data "archive_file" "application_zip" {
  type = "zip"

  source_dir  = "${path.module}/application"
  output_path = "${path.module}/application.zip"
}

## Watch for changes in ZIP SHA - used as a watcher for updated in the app sources
resource "null_resource" "sha_change_checker" {
  triggers = {
    src_hash = "${data.archive_file.application_zip.output_sha}"
  }

  provisioner "local-exec" {
    command = "echo Changes discovered in app code"
  }
}

# Upload app code archive from runner to S3 
resource "aws_s3_object" "application_code_file" {
  bucket = data.aws_s3_bucket.bucket.id

  key    = "application.zip"
  source = data.archive_file.application_zip.output_path

  etag = filemd5(data.archive_file.application_zip.output_path)
}

resource "aws_elastic_beanstalk_application" "application" {
  name = var.application_name
}

resource "aws_elastic_beanstalk_application_version" "default" {
  name        = "tf-test-version-label"
  application = aws_elastic_beanstalk_application.application.name
  description = "application version created by terraform"
  bucket      = aws_s3_bucket.bucket.id
  key         = aws_s3_object.application_code_file.id
  depends_on  = [aws_elastic_beanstalk_application.application]
}

resource "aws_elastic_beanstalk_environment" "environment" {
  name                = var.environment_name
  application         = aws_elastic_beanstalk_application.application.name
  solution_stack_name = var.solution_stack_name

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "${var.subnet1},${var.subnet2}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = "${var.subnet1},${var.subnet2}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = var.instance_profile
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = "arn:aws:iam::046086677675:role/aws-service-role/elasticbeanstalk.amazonaws.com/AWSServiceRoleForElasticBeanstalk"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     =  "True"
  }

   setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = "200"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "internet facing"
  }
 
}

# resource "null_resource" "create_app_version" {
#   depends_on = [aws_elastic_beanstalk_application.application]
  
#   triggers = {
#     app_name      = var.application_name
#     version_label = "v1"
#     s3_bucket     = var.bucket_name
#     s3_key        = "application.zip"
#   }

#   provisioner "local-exec" {
#     command = <<EOT
#       aws --region ${var.aws_region} elasticbeanstalk create-application-version --application-name ${var.application_name} --version-label "v1" --source-bundle S3Bucket=${var.bucket_name},S3Key="application.zip"
#     EOT
#   }
# }
