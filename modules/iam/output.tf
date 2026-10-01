output "ECS_EXECUTION_ROLE_ARN" {
  value = aws_iam_role.this_ecs_execution_role.arn
}

output "ECS_EXECUTION_ROLE_NAME" {
  value = aws_iam_role.this_ecs_execution_role.name
}