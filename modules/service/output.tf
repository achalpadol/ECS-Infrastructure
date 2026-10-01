output "FRONTEND_SERVICE_ID" {
  value = aws_ecs_service.this_frontend_service.id
}
output "FRONTEND_SERVICE_ARN" {
  value = aws_ecs_service.this_frontend_service.id
}
output "FRONTEND_SERVICE_NAME" {
  value = aws_ecs_service.this_frontend_service.name
}
output "BACKEND_SERVICE_ID" {
  value = aws_ecs_service.this_backend_service.id
}
output "BACKEND_SERVICE_ARN" {
  value = aws_ecs_service.this_backend_service.id
}
output "BACKEND_SERVICE_NAME" {
  value = aws_ecs_service.this_backend_service.name
}
output "DB_SERVICE_ID" {
  value = aws_ecs_service.this_db_service.id
}
output "DB_SERVICE_ARN" {
  value = aws_ecs_service.this_db_service.id
}
output "DB_SERVICE_NAME" {
  value = aws_ecs_service.this_db_service.name
}