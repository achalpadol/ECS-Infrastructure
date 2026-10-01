git status
variable "AWS_REGION" {
  type = string
}
variable "COMMON_TAGS" {
  type    = map(string)
  default = {}
}
# IAM / CLOUDWATCH
variable "ECS_EXECUTION_ROLE_ARN" {
  type = string
}
variable "LOG_GROUP_NAME" {
  type = string
}
# FRONTEND
variable "FRONTEND_TASK_FAMILY" {
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
# BACKEND
variable "BACKEND_TASK_FAMILY" {
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
# DATABASE
variable "DB_TASK_FAMILY" {
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
variable "DB_PASSWORD" {
  type      = string
  sensitive = true
}
variable "DB_NAME" {
  type = string
}