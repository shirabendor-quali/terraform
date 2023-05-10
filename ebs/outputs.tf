output "environment_url" {
  value = aws_elastic_beanstalk_environment.environment.endpoint_url
}

output "application_version" {
  value = aws_elastic_beanstalk_application_version.default[count.index].name
}


