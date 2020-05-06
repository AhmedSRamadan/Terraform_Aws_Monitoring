resource "aws_ssm_parameter" "testjson" {
  name        = "AmazonCloudWatch-Linux"
  description = "cloud watch json"
  type        = "String"
  value       = file("${path.module}/AmazonCloudWatch-Linux.json")

}

