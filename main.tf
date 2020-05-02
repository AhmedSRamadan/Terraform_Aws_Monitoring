provider "aws" {
  region = "eu-west-2"
  shared_credentials_file = "$HOME/.aws/credentials"
  profile                 = "534927035974_AdministratorAccess"
}

module "aws_sns_topic" {
  source = "./sns"
}

module "log_group" {
  source = "./log_group"
}

locals {
  metric_transformation_name      = "ErrorCount"
  metric_transformation_namespace = "MyAppNamespace"
}

module "log_metric_filter" {
  source = "./log_metric_filter"

  log_group_name = module.log_group.log_group_name

  name    = "metric-${module.log_group.id}"
  pattern = "ERROR"

  metric_transformation_namespace = local.metric_transformation_namespace
  metric_transformation_name      = local.metric_transformation_name
}

module "alarm" {
  source = "./log_metric_alarm"

  alarm_name          = "log-errors-${module.log_group.id}"
  alarm_description   = "Log errors are too high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  threshold           = 10
  period              = 60
  unit                = "Count"

  namespace   = local.metric_transformation_namespace
  metric_name = local.metric_transformation_name
  statistic   = "Sum"

  alarm_actions = [module.aws_sns_topic.this_sns_topic_arn]
}
