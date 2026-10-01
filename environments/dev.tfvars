AWS_REGION              = "ap-south-1"
VPC_NAME                = "dev-vpc"
VPC_CIDR                = "10.0.0.0/16"
PUBLIC_SUBNET_1_CIDR    = "10.0.1.0/24"
PUBLIC_SUBNET_1_AZ      = "ap-south-1a"
PUBLIC_SUBNET_2_CIDR    = "10.0.4.0/24"
PUBLIC_SUBNET_2_AZ      = "ap-south-1b"
PRIVATE_APP_SUBNET_CIDR = "10.0.2.0/24"
PRIVATE_APP_SUBNET_AZ   = "ap-south-1a"
PRIVATE_DB_SUBNET_CIDR  = "10.0.3.0/24"
PRIVATE_DB_SUBNET_AZ    = "ap-south-1b"

COMMON_TAGS = {
  Environment = "dev"
  Project     = "ECS-Infrastructure"
  ManagedBy   = "Terraform"
  Owner       = "Achal"
}
# Security Groups
SECURITY_GROUPS = {
  # ALB Security Group
  alb = {
    name        = "dev-alb-sg"
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
    name        = "dev-ecs-sg"
    description = "Security group for ECS services"
    ingress_rules = [
      {
        description                = "Allow application traffic from ALB"
        from_port                  = 8080
        to_port                    = 8080
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
    name        = "dev-db-sg"
    description = "Security group for database"
    ingress_rules = [
      {
        description                = "Allow PostgreSQL traffic from ECS"
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
#iam cloudwatch
ECS_EXECUTION_ROLE_NAME = "ecsTaskExecutionRole-dev"
LOG_GROUP_NAME          = "/ecs/dev"
LOG_RETENTION_DAYS      = 7
#ECR Repo
ECR_REPOSITORIES = {
  backend = {
    name                 = "app1-backend-dev"
    image_tag_mutability = "MUTABLE"
    scan_on_push         = true
  }
  frontend = {
    name                 = "app1-frontend-dev"
    image_tag_mutability = "MUTABLE"
    scan_on_push         = true
  }
  db = {
    name                 = "app1-db-dev"
    image_tag_mutability = "MUTABLE"
    scan_on_push         = true
  }
}
#CloudMap
CLOUD_MAP_NAMESPACE = "ecs.dev.local"
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
ALB_NAME                   = "dev-app-alb"
TARGET_GROUP_NAME          = "dev-app-tg"
TARGET_GROUP_PORT          = 80
HEALTH_CHECK_PATH          = "/"
ENABLE_DELETION_PROTECTION = false
# ECS CLUSTER
ECS_CLUSTER_NAME = "dev-app-cluster"
# FRONTEND
FRONTEND_TASK_FAMILY    = "dev-frontend"
FRONTEND_SERVICE_NAME   = "dev-frontend-service"
FRONTEND_IMAGE          = "nginx:latest"
FRONTEND_CONTAINER_PORT = 80
FRONTEND_CPU            = 256
FRONTEND_MEMORY         = 512
FRONTEND_DESIRED_COUNT  = 1
# BACKEND
BACKEND_TASK_FAMILY    = "dev-backend"
BACKEND_SERVICE_NAME   = "dev-backend-service"
BACKEND_IMAGE          = "hashicorp/http-echo:1.0"
BACKEND_CONTAINER_PORT = 8080
BACKEND_CPU            = 256
BACKEND_MEMORY         = 512
BACKEND_DESIRED_COUNT  = 1
# DATABASE
DB_TASK_FAMILY    = "dev-db"
DB_SERVICE_NAME   = "dev-db-service"
DB_IMAGE          = "mysql:8.0"
DB_CONTAINER_PORT = 3306
DB_CPU            = 512
DB_MEMORY         = 1024
DB_DESIRED_COUNT  = 1
DB_NAME           = "example"
MYSQL_HOST        = "db.ecs.dev.local"
DB_PASSWORD       = "Achal123"
DB_USER           = "root"
