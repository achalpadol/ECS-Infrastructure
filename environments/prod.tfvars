AWS_REGION              = "ap-south-1"
VPC_NAME                = "prod-vpc"
VPC_CIDR                = "10.3.0.0/16"
PUBLIC_SUBNET_1_CIDR    = "10.0.1.0/24"
PUBLIC_SUBNET_1_AZ      = "ap-south-1a"
PUBLIC_SUBNET_2_CIDR    = "10.0.4.0/24"
PUBLIC_SUBNET_2_AZ      = "ap-south-1b"
PRIVATE_APP_SUBNET_CIDR = "10.3.2.0/24"
PRIVATE_APP_SUBNET_AZ   = "ap-south-1a"
PRIVATE_DB_SUBNET_CIDR  = "10.3.3.0/24"
PRIVATE_DB_SUBNET_AZ    = "ap-south-1b"
COMMON_TAGS = {
  Environment = "prod"
  Project     = "ECS-Infrastructure"
  ManagedBy   = "Terraform"
  Owner       = "Achal"
}
# Security Groups
SECURITY_GROUPS = {
  # ALB Security Group
  alb = {
    name        = "prod-alb-sg"
    description = "Security group for Application Load Balancer"
    ingress_rules = [
      {
        description = "Allow HTTP traffic"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_ipv4   = "0.0.0.0/0"
      },
      {
        description = "Allow HTTPS traffic"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_ipv4   = "0.0.0.0/0"
      }
    ]
    egress_rules = [
      {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_ipv4   = "0.0.0.0/0"
      }
    ]
  }
  # ECS Security Group
  ecs = {
    name        = "prod-ecs-sg"
    description = "Security group for ECS services"
    ingress_rules = [
      {
        description                = "Allow application traffic from ALB"
        from_port                  = 8000
        to_port                    = 8000
        protocol                   = "tcp"
        source_security_group_name = "alb"
      }
    ]
    egress_rules = [
      {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_ipv4   = "0.0.0.0/0"
      }
    ]
  }
  # DB Security Group
  db = {
    name        = "prod-db-sg"
    description = "Security group for database"
    ingress_rules = [
      {
        description                = "Allow PostgreSQL traffic from ECS"
        from_port                  = 5432
        to_port                    = 5432
        protocol                   = "tcp"
        source_security_group_name = "ecs"
      }
    ]
    egress_rules = [
      {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_ipv4   = "0.0.0.0/0"
      }
    ]
  }
}
#iam cloudwatch
ECS_EXECUTION_ROLE_NAME = "ecsTaskExecutionRole-prod"
LOG_GROUP_NAME          = "/ecs/prod"
LOG_RETENTION_DAYS      = 7
#ECR Repo
ECR_REPOSITORIES = {
  backend = {
    name                 = "app1-backend-prod"
    image_tag_mutability = "MUTABLE"
    scan_on_push         = true
  }
  frontend = {
    name                 = "app1-frontend-prod"
    image_tag_mutability = "MUTABLE"
    scan_on_push         = true
  }
  db = {
    name                 = "app1-db-prod"
    image_tag_mutability = "MUTABLE"
    scan_on_push         = true
  }
}
#CLoudMap
CLOUD_MAP_NAMESPACE = "ecs.prod.local"
CLOUD_MAP_SERVICES = {
  backend = {
    name              = "backend"
    ttl               = 10
    routing_policy    = "MULTIVALUE"
    failure_threshold = 1
  }
  db = {
    name              = "db"
    ttl               = 10
    routing_policy    = "MULTIVALUE"
    failure_threshold = 1
  }
}
#ALB
ALB_NAME                   = "prod-app-alb"
TARGET_GROUP_NAME          = "prod-app-tg"
TARGET_GROUP_PORT          = 8000
HEALTH_CHECK_PATH          = "/"
ENABLE_DELETION_PROTECTION = false
# ECS CLUSTER
ECS_CLUSTER_NAME = "prod-app-cluster"
# FRONTEND
FRONTEND_TASK_FAMILY    = "prod-frontend"
FRONTEND_SERVICE_NAME   = "prod-frontend-service"
FRONTEND_IMAGE          = "hashicorp/http-echo:1.0"
FRONTEND_CONTAINER_PORT = 8000
FRONTEND_CPU            = 512
FRONTEND_MEMORY         = 1024
FRONTEND_DESIRED_COUNT  = 2
# BACKEND
BACKEND_TASK_FAMILY    = "prod-backend"
BACKEND_SERVICE_NAME   = "prod-backend-service"
BACKEND_IMAGE          = "hashicorp/http-echo:1.0"
BACKEND_CONTAINER_PORT = 8000
BACKEND_CPU            = 512
BACKEND_MEMORY         = 1024
BACKEND_DESIRED_COUNT  = 2
# DATABASE
DB_TASK_FAMILY    = "prod-db"
DB_SERVICE_NAME   = "prod-db-service"
DB_IMAGE          = "postgres:16-alpine"
DB_CONTAINER_PORT = 5432
DB_CPU            = 1024
DB_MEMORY         = 2048
DB_DESIRED_COUNT  = 1
DB_PASSWORD       = "ProdPassword123!"
DB_NAME           = "appdb"