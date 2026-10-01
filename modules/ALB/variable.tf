variable "VPC_ID" {
  description = "VPC ID where ALB target group will be created"
  type        = string
}
variable "PUBLIC_SUBNET_IDS" {
  description = "Public subnet IDs for the ALB"
  type        = list(string)
}
variable "ALB_SECURITY_GROUP_ID" {
  description = "Existing security group ID for the ALB"
  type        = string
}
variable "ALB_NAME" {
  description = "Application Load Balancer name"
  type        = string
}
variable "TARGET_GROUP_NAME" {
  description = "Target group name"
  type        = string
}
variable "TARGET_GROUP_PORT" {
  description = "Port where ECS application listens"
  type        = number
}
variable "HEALTH_CHECK_PATH" {
  description = "Health check path for ECS application"
  type        = string
  default     = "/"
}
variable "ENABLE_DELETION_PROTECTION" {
  description = "Enable ALB deletion protection"
  type        = bool
  default     = false
}
variable "COMMON_TAGS" {
  description = "Common tags for ALB resources"
  type        = map(string)
  default     = {}
}