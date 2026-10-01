output "FRONTEND_TASK_DEFINITION_ARN" {
  value = aws_ecs_task_definition.this_frontend_task_definition.arn
}
output "FRONTEND_TASK_DEFINITION_FAMILY" {
  value = aws_ecs_task_definition.this_frontend_task_definition.family
}
output "BACKEND_TASK_DEFINITION_ARN" {
  value = aws_ecs_task_definition.this_backend_task_definition.arn
}
output "BACKEND_TASK_DEFINITION_FAMILY" {
  value = aws_ecs_task_definition.this_backend_task_definition.family
}
output "DB_TASK_DEFINITION_ARN" {
  value = aws_ecs_task_definition.this_db_task_definition.arn
}
output "DB_TASK_DEFINITION_FAMILY" {
  value = aws_ecs_task_definition.this_db_task_definition.family
}