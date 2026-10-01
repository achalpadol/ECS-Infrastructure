resource "aws_cloudwatch_log_group" "this_log_group" {
  name              = var.LOG_GROUP_NAME
  retention_in_days = var.LOG_RETENTION_DAYS
  tags = merge(
    var.COMMON_TAGS,
    {
      Name = var.LOG_GROUP_NAME
    }
  )
}