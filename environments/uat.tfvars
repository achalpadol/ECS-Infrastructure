AWS_REGION              = "ap-south-1"
VPC_NAME                = "uat-vpc"
VPC_CIDR                = "10.2.0.0/16"

PUBLIC_SUBNET_1_CIDR    = "10.2.1.0/24"
PUBLIC_SUBNET_1_AZ      = "ap-south-1a"

PUBLIC_SUBNET_2_CIDR    = "10.2.4.0/24"
PUBLIC_SUBNET_2_AZ      = "ap-south-1b"

PRIVATE_APP_SUBNET_CIDR = "10.2.2.0/24"
PRIVATE_APP_SUBNET_AZ   = "ap-south-1a"

PRIVATE_DB_SUBNET_CIDR  = "10.2.3.0/24"
PRIVATE_DB_SUBNET_AZ    = "ap-south-1b"
# Common Tags
COMMON_TAGS = {
  Environment = "uat"
  Project     = "ECS-Infrastructure"
  ManagedBy   = "Terraform"
  Owner       = "Achal"
}
# Security Groups
SECURITY_GROUPS = {
# ALB Security Group
  alb = {
    name        = "uat-alb-sg"
    description = "Security group for Application Load Balancer"
    ingress_rules = [
      {
        description = "Allow HTTP traffic"
        from_port   = 80
        to_port     = 80
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
    name        = "uat-ecs-sg"
    description = "Security group for ECS services"
    ingress_rules = [
      {
        description                = "Allow application traffic from ALB"
        from_port                  = 8080
        to_port                    = 8080
        protocol                   = "tcp"
        source_security_group_name = "alb"
      },
      {
        description = "Allow HTTP traffic"
        from_port   = 80
        to_port     = 80
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
  # DB Security Group
  db = {
    name        = "uat-db-sg"
    description = "Security group for database"
    ingress_rules = [
      {
        description                = "Allow MySQL traffic from ECS"
        from_port                  = 3306
        to_port                    = 3306
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
# IAM / CloudWatch
ECS_EXECUTION_ROLE_NAME = "ecsTaskExecutionRole-uat"
LOG_GROUP_NAME          = "/ecs/uat"
LOG_RETENTION_DAYS      = 7
# ECR Repositories
ECR_REPOSITORIES = {
  backend = {
    name                 = "app3-backend-uat"
    image_tag_mutability = "MUTABLE"
    scan_on_push         = true
  }
  frontend = {
    name                 = "app3-frontend-uat"
    image_tag_mutability = "MUTABLE"
    scan_on_push         = true
  }
  db = {
    name                 = "app3-db-uat"
    image_tag_mutability = "MUTABLE"
    scan_on_push         = true
  }
}
# Cloud Map
CLOUD_MAP_NAMESPACE = "ecs.uat.local"
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
# ALB
ALB_NAME                   = "uat-app-alb"
TARGET_GROUP_NAME          = "uat-app-tg"
TARGET_GROUP_PORT          = 80
HEALTH_CHECK_PATH          = "/"
ENABLE_DELETION_PROTECTION = false
# ECS Cluster
ECS_CLUSTER_NAME = "uat-app-cluster"
# FRONTEND
FRONTEND_TASK_FAMILY    = "uat-frontend"
FRONTEND_SERVICE_NAME   = "uat-frontend-service"
FRONTEND_IMAGE          = "nginx:latest"
FRONTEND_CONTAINER_PORT = 80
FRONTEND_CPU            = 256
FRONTEND_MEMORY         = 512
FRONTEND_DESIRED_COUNT  = 1
# BACKEND
BACKEND_TASK_FAMILY    = "uat-backend"
BACKEND_SERVICE_NAME   = "uat-backend-service"
BACKEND_IMAGE          = "hashicorp/http-echo:1.0"
BACKEND_CONTAINER_PORT = 8080
BACKEND_CPU            = 256
BACKEND_MEMORY         = 512
BACKEND_DESIRED_COUNT  = 1
# DATABASE
DB_TASK_FAMILY    = "uat-db"
DB_SERVICE_NAME   = "uat-db-service"
DB_IMAGE          = "mysql:8.0"
DB_CONTAINER_PORT = 3306
DB_CPU             = 512
DB_MEMORY          = 1024
DB_DESIRED_COUNT  = 1
DB_NAME           = "example"
MYSQL_HOST        = "db.ecs.uat.local"
DB_PASSWORD       = "Achal123"
DB_USER           = "root"