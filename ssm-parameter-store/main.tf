resource "aws_ssm_parameter" "testjson" {
  name        = "test-json"
  description = "cloud watch json"
  type        = "String"
  value       = file("${path.module}/AmazonCloudWatch-Linux.json")

}

