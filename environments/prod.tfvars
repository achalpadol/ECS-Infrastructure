AWS_REGION              = "ap-south-1"
VPC_NAME                = "prod-vpc"
VPC_CIDR                = "10.3.0.0/16"
PUBLIC_SUBNET_1_CIDR    = "10.3.1.0/24"
PUBLIC_SUBNET_1_AZ      = "ap-south-1a"
PUBLIC_SUBNET_2_CIDR    = "10.3.4.0/24"
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
  alb = {
    name        = "prod-alb-sg"
    description = "Security group for Application Load Balancer"
    ingress_rules = [
      {
        description = "Allow HTTP from internet"
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

  frontend = {
    name        = "prod-frontend-sg"
    description = "Security group for frontend ECS service"
    ingress_rules = [
      {
        description                = "Allow HTTP from ALB"
        from_port                  = 80
        to_port                    = 80
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

  backend = {
    name        = "prod-backend-sg"
    description = "Security group for backend ECS service"
    ingress_rules = [
      {
        description                = "Allow backend traffic from frontend"
        from_port                  = 8080
        to_port                    = 8080
        protocol                   = "tcp"
        source_security_group_name = "frontend"
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

  db = {
    name        = "prod-db-sg"
    description = "Security group for database ECS service"
    ingress_rules = [
      {
        description                = "Allow MySQL traffic from backend"
        from_port                  = 3306
        to_port                    = 3306
        protocol                   = "tcp"
        source_security_group_name = "backend"
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

# iam cloudwatch
ECS_EXECUTION_ROLE_NAME = "ecsTaskExecutionRole-prod"
LOG_GROUP_NAME          = "/ecs/prod"
LOG_RETENTION_DAYS      = 7

# ECR Repo
ECR_REPOSITORIES = {
  backend = {
    name                 = "app3-backend-prod"
    image_tag_mutability = "MUTABLE"
    scan_on_push         = true
  }
  frontend = {
    name                 = "app3-frontend-prod"
    image_tag_mutability = "MUTABLE"
    scan_on_push         = true
  }
  db = {
    name                 = "app3-db-prod"
    image_tag_mutability = "MUTABLE"
    scan_on_push         = true
  }
}

# CloudMap
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

# ALB
ALB_NAME                   = "prod-app-alb"
TARGET_GROUP_NAME          = "prod-app-tg"
TARGET_GROUP_PORT          = 80
HEALTH_CHECK_PATH          = "/"
ENABLE_DELETION_PROTECTION = false

# ECS CLUSTER
ECS_CLUSTER_NAME = "prod-app-cluster"

# FRONTEND
FRONTEND_TASK_FAMILY    = "prod-frontend"
FRONTEND_SERVICE_NAME   = "prod-frontend-service"
FRONTEND_IMAGE          = "nginx:latest"
FRONTEND_CONTAINER_PORT = 80
FRONTEND_CPU            = 256
FRONTEND_MEMORY         = 512
FRONTEND_DESIRED_COUNT  = 1

# BACKEND
BACKEND_TASK_FAMILY    = "prod-backend"
BACKEND_SERVICE_NAME   = "prod-backend-service"
BACKEND_IMAGE          = "hashicorp/http-echo:1.0"
BACKEND_CONTAINER_PORT = 8080
BACKEND_CPU            = 256
BACKEND_MEMORY         = 512
BACKEND_DESIRED_COUNT  = 1

# DATABASE
DB_TASK_FAMILY    = "prod-db"
DB_SERVICE_NAME   = "prod-db-service"
DB_IMAGE          = "mysql:8.0"
DB_CONTAINER_PORT = 3306
DB_CPU            = 512
DB_MEMORY         = 1024
DB_DESIRED_COUNT  = 1
DB_NAME           = "example"
MYSQL_HOST        = "db.ecs.prod.local"
DB_PASSWORD       = "Achal123"
DB_USER           = "root"