output "VPC_ID" {
  description = "VPC ID"
  value       = module.vpc.VPC_ID
}
output "VPC_CIDR" {
  description = "VPC CIDR"
  value       = module.vpc.VPC_CIDR
}
output "PUBLIC_SUBNET_IDS" {
  description = "Public subnet IDs"
  value       = module.vpc.PUBLIC_SUBNET_IDS
}
output "PRIVATE_APP_SUBNET_ID" {
  description = "Private application subnet ID"
  value       = module.vpc.PRIVATE_APP_SUBNET_ID
}
output "PRIVATE_DB_SUBNET_ID" {
  description = "Private database subnet ID"
  value       = module.vpc.PRIVATE_DB_SUBNET_ID
}
/*output "NAT_GATEWAY_ID" {
  description = "NAT Gateway ID"
  value       = module.vpc.NAT_GATEWAY_ID
}*/
#sg
output "SECURITY_GROUP_IDS" {
  description = "Security group IDs"
  value       = module.security_group.SECURITY_GROUP_IDS
}
output "SECURITY_GROUP_NAMES" {
  description = "Security group names"
  value       = module.security_group.SECURITY_GROUP_NAMES
}
#ECR Repo
output "ECR_REPOSITORY_URLS" {
  description = "ECR repository URLs"
  value       = module.ecr.ECR_REPOSITORY_URLS
}
output "ECR_REPOSITORY_ARNS" {
  description = "ECR repository ARNs"
  value       = module.ecr.ECR_REPOSITORY_ARNS
}
output "ECR_REPOSITORY_NAMES" {
  description = "ECR repository names"
  value       = module.ecr.ECR_REPOSITORY_NAMES
}
#CloudMap
output "CLOUD_MAP_NAMESPACE_ID" {
  description = "Cloud Map namespace ID"
  value       = module.cloud_map.CLOUD_MAP_NAMESPACE_ID
}
output "CLOUD_MAP_NAMESPACE_ARN" {
  description = "Cloud Map namespace ARN"
  value       = module.cloud_map.CLOUD_MAP_NAMESPACE_ARN
}
output "CLOUD_MAP_NAMESPACE_NAME" {
  description = "Cloud Map namespace name"
  value       = module.cloud_map.CLOUD_MAP_NAMESPACE_NAME
}
output "CLOUD_MAP_SERVICE_IDS" {
  description = "Cloud Map service IDs"
  value       = module.cloud_map.CLOUD_MAP_SERVICE_IDS
}
output "CLOUD_MAP_SERVICE_ARNS" {
  description = "Cloud Map service ARNs"
  value       = module.cloud_map.CLOUD_MAP_SERVICE_ARNS
}
output "CLOUD_MAP_SERVICE_NAMES" {
  description = "Cloud Map service names"
  value       = module.cloud_map.CLOUD_MAP_SERVICE_NAMES
}
#iam
output "ECS_EXECUTION_ROLE_ARN" {
  value = module.iam.ECS_EXECUTION_ROLE_ARN
}
output "ECS_EXECUTION_ROLE_NAME" {
  value = module.iam.ECS_EXECUTION_ROLE_NAME
}
#cloudwatch
output "LOG_GROUP_NAME" {
  value = module.cloudwatch.LOG_GROUP_NAME
}
output "LOG_GROUP_ARN" {
  value = module.cloudwatch.LOG_GROUP_ARN
}
# ECS CLUSTER
output "ECS_CLUSTER_ID" {
  value = module.ecs_cluster.ECS_CLUSTER_ID
}
output "ECS_CLUSTER_ARN" {
  value = module.ecs_cluster.ECS_CLUSTER_ARN
}
output "ECS_CLUSTER_NAME" {
  value = module.ecs_cluster.ECS_CLUSTER_NAME
}
# FRONTEND TASK DEFINITION
output "FRONTEND_TASK_DEFINITION_ARN" {
  value = module.ecs_task_definition.FRONTEND_TASK_DEFINITION_ARN
}
output "FRONTEND_TASK_DEFINITION_FAMILY" {
  value = module.ecs_task_definition.FRONTEND_TASK_DEFINITION_FAMILY
}
# BACKEND TASK DEFINITION
output "BACKEND_TASK_DEFINITION_ARN" {
  value = module.ecs_task_definition.BACKEND_TASK_DEFINITION_ARN
}
output "BACKEND_TASK_DEFINITION_FAMILY" {
  value = module.ecs_task_definition.BACKEND_TASK_DEFINITION_FAMILY
}
# DATABASE TASK DEFINITION
output "DB_TASK_DEFINITION_ARN" {
  value = module.ecs_task_definition.DB_TASK_DEFINITION_ARN
}
output "DB_TASK_DEFINITION_FAMILY" {
  value = module.ecs_task_definition.DB_TASK_DEFINITION_FAMILY
}
# FRONTEND SERVICE
output "FRONTEND_SERVICE_ID" {
  value = module.ecs_service.FRONTEND_SERVICE_ID
}
output "FRONTEND_SERVICE_NAME" {
  value = module.ecs_service.FRONTEND_SERVICE_NAME
}
# BACKEND SERVICE
output "BACKEND_SERVICE_ID" {
  value = module.ecs_service.BACKEND_SERVICE_ID
}
output "BACKEND_SERVICE_NAME" {
  value = module.ecs_service.BACKEND_SERVICE_NAME
}
# DATABASE SERVICE
output "DB_SERVICE_ID" {
  value = module.ecs_service.DB_SERVICE_ID
}
output "DB_SERVICE_NAME" {
  value = module.ecs_service.DB_SERVICE_NAME
}