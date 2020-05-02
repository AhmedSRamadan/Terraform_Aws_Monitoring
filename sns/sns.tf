resource "aws_sns_topic" "this" {
  name = "metrics-alarms-topic"
}

output "this_sns_topic_arn" {
  value = aws_sns_topic.this.arn
}

output "this_sns_topic_name" {
  value = aws_sns_topic.this.name
}