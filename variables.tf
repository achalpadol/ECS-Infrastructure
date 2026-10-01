variable "AWS_REGION" {
  description = "AWS region"
  type        = string
}
variable "VPC_NAME" {
  description = "Name of the VPC"
  type        = string
}
variable "VPC_CIDR" {
  description = "CIDR block for the VPC"
  type        = string
}
variable "PUBLIC_SUBNET_1_CIDR" {
  description = "CIDR block for public subnet 1"
  type        = string
}
variable "PUBLIC_SUBNET_1_AZ" {
  description = "Availability Zone for public subnet 1"
  type        = string
}
variable "PUBLIC_SUBNET_2_CIDR" {
  description = "CIDR block for public subnet 2"
  type        = string
}
variable "PUBLIC_SUBNET_2_AZ" {
  description = "Availability Zone for public subnet 2"
  type        = string
}
variable "PRIVATE_APP_SUBNET_CIDR" {
  description = "CIDR block for the private application subnet"
  type        = string
}
variable "PRIVATE_APP_SUBNET_AZ" {
  description = "Availability Zone for the private application subnet"
  type        = string
}
variable "PRIVATE_DB_SUBNET_CIDR" {
  description = "CIDR block for the private database subnet"
  type        = string
}
variable "PRIVATE_DB_SUBNET_AZ" {
  description = "Availability Zone for the private database subnet"
  type        = string
}
variable "COMMON_TAGS" {
  description = "Common tags used by all infrastructure resources"
  type        = map(string)
  default     = {}
}
# sg
variable "SECURITY_GROUPS" {
  description = "Security groups and their inbound and outbound rules"
  type = map(object({
    name        = string
    description = string
    ingress_rules = list(object({
      description                = string
      from_port                  = number
      to_port                    = number
      protocol                   = string
      cidr_ipv4                  = optional(string)
      source_security_group_name = optional(string)
    }))
    egress_rules = list(object({
      description = string
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_ipv4   = optional(string)
    }))
  }))
}
#ECR Repo
variable "ECR_REPOSITORIES" {
  description = "ECR repositories for the environment"
  type = map(object({
    name                 = string
    image_tag_mutability = string
    scan_on_push         = bool
  }))
}
#CloudMap
variable "CLOUD_MAP_NAMESPACE" {
  description = "Cloud Map private DNS namespace"
  type        = string
}
variable "CLOUD_MAP_SERVICES" {
  description = "Cloud Map services"
  type = map(object({
    name              = string
    ttl               = number
    routing_policy    = string
    failure_threshold = number
  }))
}
#ALB
variable "ALB_NAME" {
  description = "Application Load Balancer name"
  type        = string
}
variable "TARGET_GROUP_NAME" {
  description = "Target group name"
  type        = string
}
variable "TARGET_GROUP_PORT" {
  description = "Port where the ECS frontend container listens"
  type        = number
}
variable "HEALTH_CHECK_PATH" {
  description = "Health check path for the ECS frontend"
  type        = string
  default     = "/"
}
variable "ENABLE_DELETION_PROTECTION" {
  description = "Enable ALB deletion protection"
  type        = bool
  default     = false
}
#iam
variable "ECS_EXECUTION_ROLE_NAME" {
  type = string
}
#cloudwatch
variable "LOG_GROUP_NAME" {
  type = string
}
variable "LOG_RETENTION_DAYS" {
  type = number
}
# ECS CLUSTER
variable "ECS_CLUSTER_NAME" {
  type = string
}
# FRONTEND TASK DEFINITION
variable "FRONTEND_TASK_FAMILY" {
  type = string
}
variable "FRONTEND_SERVICE_NAME" {
  type = string
}
variable "FRONTEND_IMAGE" {
  type = string
}
variable "FRONTEND_CONTAINER_PORT" {
  type = number
}
variable "FRONTEND_CPU" {
  type = number
}
variable "FRONTEND_MEMORY" {
  type = number
}
variable "FRONTEND_DESIRED_COUNT" {
  type = number
}
# BACKEND TASK DEFINITION
variable "BACKEND_TASK_FAMILY" {
  type = string
}
variable "BACKEND_SERVICE_NAME" {
  type = string
}
variable "BACKEND_IMAGE" {
  type = string
}
variable "BACKEND_CONTAINER_PORT" {
  type = number
}
variable "BACKEND_CPU" {
  type = number
}
variable "BACKEND_MEMORY" {
  type = number
}
variable "BACKEND_DESIRED_COUNT" {
  type = number
}
# DATABASE TASK DEFINITION
variable "DB_TASK_FAMILY" {
  type = string
}
variable "DB_SERVICE_NAME" {
  type = string
}
variable "DB_IMAGE" {
  type = string
}
variable "DB_CONTAINER_PORT" {
  type = number
}
variable "DB_CPU" {
  type = number
}
variable "DB_MEMORY" {
  type = number
}
variable "DB_DESIRED_COUNT" {
  type = number
}
variable "DB_PASSWORD" {
  type      = string
  sensitive = true
}
variable "DB_NAME" {
  type = string
}