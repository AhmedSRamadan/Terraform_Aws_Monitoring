resource "aws_cloudwatch_log_group" "this" {
  name = "oom_log_group"
}

output "log_group_name" {
  value = aws_cloudwatch_log_group.this.name

}

output "id" {
  value = aws_cloudwatch_log_group.this.id
}



