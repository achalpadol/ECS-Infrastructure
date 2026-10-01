output "ECS_CLUSTER_ID" {
  value = aws_ecs_cluster.this_cluster.id
}
output "ECS_CLUSTER_ARN" {
  value = aws_ecs_cluster.this_cluster.arn
}
output "ECS_CLUSTER_NAME" {
  value = aws_ecs_cluster.this_cluster.name
}