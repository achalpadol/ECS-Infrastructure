output "LOG_GROUP_NAME" {
  value = aws_cloudwatch_log_group.this_log_group.name
}

output "LOG_GROUP_ARN" {
  value = aws_cloudwatch_log_group.this_log_group.arn
}