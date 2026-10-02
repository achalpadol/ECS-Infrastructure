variable "COMMON_TAGS" {
  type    = map(string)
  default = {}
}
# ECS CLUSTER
variable "ECS_CLUSTER_ARN" {
  type = string
}
# NETWORK
variable "PRIVATE_APP_SUBNET_IDS" {
  type = list(string)
}
variable "ECS_SECURITY_GROUP_ID" {
  type = string
}
# ALB
variable "TARGET_GROUP_ARN" {
  type = string
}
# CLOUD MAP
variable "BACKEND_CLOUD_MAP_SERVICE_ARN" {
  type = string
}
variable "DB_CLOUD_MAP_SERVICE_ARN" {
  type = string
}
# FRONTEND
variable "FRONTEND_TASK_DEFINITION_ARN" {
  type = string
}
variable "FRONTEND_SERVICE_NAME" {
  type = string
}
variable "FRONTEND_CONTAINER_PORT" {
  type = number
}
variable "FRONTEND_DESIRED_COUNT" {
  type = number
}
# BACKEND
variable "BACKEND_TASK_DEFINITION_ARN" {
  type = string
}
variable "BACKEND_SERVICE_NAME" {
  type = string
}
variable "BACKEND_CONTAINER_PORT" {
  type = number
}
variable "BACKEND_DESIRED_COUNT" {
  type = number
}
# DATABASE
variable "DB_TASK_DEFINITION_ARN" {
  type = string
}
variable "DB_SERVICE_NAME" {
  type = string
}
variable "DB_CONTAINER_PORT" {
  type = number
}
variable "DB_DESIRED_COUNT" {
  type = number
}
variable "DB_SECURITY_GROUP_ID" {
  description = "Security group ID for database ECS service"
  type        = string
}
