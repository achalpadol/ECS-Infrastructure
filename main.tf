module "vpc" {
  source = "./modules/vpc"

  AWS_REGION              = var.AWS_REGION
  VPC_NAME                = var.VPC_NAME
  VPC_CIDR                = var.VPC_CIDR
  PUBLIC_SUBNET_1_CIDR    = var.PUBLIC_SUBNET_1_CIDR
  PUBLIC_SUBNET_1_AZ      = var.PUBLIC_SUBNET_1_AZ
  PUBLIC_SUBNET_2_CIDR    = var.PUBLIC_SUBNET_2_CIDR
  PUBLIC_SUBNET_2_AZ      = var.PUBLIC_SUBNET_2_AZ
  PRIVATE_APP_SUBNET_CIDR = var.PRIVATE_APP_SUBNET_CIDR
  PRIVATE_APP_SUBNET_AZ   = var.PRIVATE_APP_SUBNET_AZ
  PRIVATE_DB_SUBNET_CIDR  = var.PRIVATE_DB_SUBNET_CIDR
  PRIVATE_DB_SUBNET_AZ    = var.PRIVATE_DB_SUBNET_AZ
  COMMON_TAGS             = var.COMMON_TAGS
}
# Security Groups
module "security_group" {
  source          = "./modules/security-group"
  VPC_ID          = module.vpc.VPC_ID
  COMMON_TAGS     = var.COMMON_TAGS
  SECURITY_GROUPS = var.SECURITY_GROUPS
}
#ECR Repo
module "ecr" {
  source           = "./modules/ecr"
  ECR_REPOSITORIES = var.ECR_REPOSITORIES
  COMMON_TAGS      = var.COMMON_TAGS
}
# Cloud Map
module "cloud_map" {
  source              = "./modules/cloudmap"
  VPC_ID              = module.vpc.VPC_ID
  CLOUD_MAP_NAMESPACE = var.CLOUD_MAP_NAMESPACE
  CLOUD_MAP_SERVICES  = var.CLOUD_MAP_SERVICES
  COMMON_TAGS         = var.COMMON_TAGS
}
#ALB
# Application Load Balancer
module "alb" {
  source                     = "./modules/ALB"
  VPC_ID                     = module.vpc.VPC_ID
  PUBLIC_SUBNET_IDS          = module.vpc.PUBLIC_SUBNET_IDS
  ALB_SECURITY_GROUP_ID      = module.security_group.SECURITY_GROUP_IDS["alb"]
  ALB_NAME                   = var.ALB_NAME
  TARGET_GROUP_NAME          = var.TARGET_GROUP_NAME
  TARGET_GROUP_PORT          = var.TARGET_GROUP_PORT
  HEALTH_CHECK_PATH          = var.HEALTH_CHECK_PATH
  ENABLE_DELETION_PROTECTION = var.ENABLE_DELETION_PROTECTION
  COMMON_TAGS                = var.COMMON_TAGS
}
#IAM
module "iam" {
  source                  = "./modules/iam"
  ECS_EXECUTION_ROLE_NAME = var.ECS_EXECUTION_ROLE_NAME
  COMMON_TAGS             = var.COMMON_TAGS
}
# Cloud Watch
module "cloudwatch" {
  source             = "./modules/cloudwatch"
  LOG_GROUP_NAME     = var.LOG_GROUP_NAME
  LOG_RETENTION_DAYS = var.LOG_RETENTION_DAYS
  COMMON_TAGS        = var.COMMON_TAGS
}
# ECS CLUSTER
module "ecs_cluster" {
  source           = "./modules/cluster"
  ECS_CLUSTER_NAME = var.ECS_CLUSTER_NAME
  COMMON_TAGS      = var.COMMON_TAGS
}
# ECS TASK DEFINITIONS
module "ecs_task_definition" {
  source                 = "./modules/task-definition"
  AWS_REGION             = var.AWS_REGION
  COMMON_TAGS            = var.COMMON_TAGS
  ECS_EXECUTION_ROLE_ARN = module.iam.ECS_EXECUTION_ROLE_ARN
  LOG_GROUP_NAME         = module.cloudwatch.LOG_GROUP_NAME
  # FRONTEND
  FRONTEND_TASK_FAMILY    = var.FRONTEND_TASK_FAMILY
  FRONTEND_IMAGE          = var.FRONTEND_IMAGE
  FRONTEND_CONTAINER_PORT = var.FRONTEND_CONTAINER_PORT
  FRONTEND_CPU            = var.FRONTEND_CPU
  FRONTEND_MEMORY         = var.FRONTEND_MEMORY
  # BACKEND
  BACKEND_TASK_FAMILY    = var.BACKEND_TASK_FAMILY
  BACKEND_IMAGE          = var.BACKEND_IMAGE
  BACKEND_CONTAINER_PORT = var.BACKEND_CONTAINER_PORT
  BACKEND_CPU            = var.BACKEND_CPU
  BACKEND_MEMORY         = var.BACKEND_MEMORY
  # DATABASE
  DB_TASK_FAMILY    = var.DB_TASK_FAMILY
  DB_IMAGE          = var.DB_IMAGE
  DB_CONTAINER_PORT = var.DB_CONTAINER_PORT
  DB_CPU            = var.DB_CPU
  DB_MEMORY         = var.DB_MEMORY
  DB_PASSWORD       = var.DB_PASSWORD
  DB_NAME           = var.DB_NAME
  MYSQL_HOST        = var.MYSQL_HOST
  DB_USER           = var.DB_USER
}
# ECS SERVICES
module "ecs_service" {
  source      = "./modules/service"
  COMMON_TAGS = var.COMMON_TAGS
  # ECS CLUSTER
  ECS_CLUSTER_ARN = module.ecs_cluster.ECS_CLUSTER_ARN
  # NETWORK
  PRIVATE_APP_SUBNET_IDS = [
    module.vpc.PRIVATE_APP_SUBNET_ID
  ]
  ECS_SECURITY_GROUP_ID = module.security_group.SECURITY_GROUP_IDS["ecs"]
  # ALB
  TARGET_GROUP_ARN = module.alb.TARGET_GROUP_ARN
  # CLOUD MAP
  BACKEND_CLOUD_MAP_SERVICE_ARN = module.cloud_map.CLOUD_MAP_SERVICE_ARNS["backend"]
  DB_CLOUD_MAP_SERVICE_ARN      = module.cloud_map.CLOUD_MAP_SERVICE_ARNS["db"]
  # FRONTEND
  FRONTEND_TASK_DEFINITION_ARN = module.ecs_task_definition.FRONTEND_TASK_DEFINITION_ARN
  FRONTEND_SERVICE_NAME        = var.FRONTEND_SERVICE_NAME
  FRONTEND_CONTAINER_PORT      = var.FRONTEND_CONTAINER_PORT
  FRONTEND_DESIRED_COUNT       = var.FRONTEND_DESIRED_COUNT
  # BACKEND
  BACKEND_TASK_DEFINITION_ARN = module.ecs_task_definition.BACKEND_TASK_DEFINITION_ARN
  BACKEND_SERVICE_NAME        = var.BACKEND_SERVICE_NAME
  BACKEND_CONTAINER_PORT      = var.BACKEND_CONTAINER_PORT
  BACKEND_DESIRED_COUNT       = var.BACKEND_DESIRED_COUNT
  # DATABASE
  DB_TASK_DEFINITION_ARN = module.ecs_task_definition.DB_TASK_DEFINITION_ARN
  DB_SERVICE_NAME        = var.DB_SERVICE_NAME
  DB_CONTAINER_PORT      = var.DB_CONTAINER_PORT
  DB_DESIRED_COUNT       = var.DB_DESIRED_COUNT
}
