variable "VPC_ID" {
  description = "VPC ID where Cloud Map namespace will be created"
  type        = string
}
variable "CLOUD_MAP_NAMESPACE" {
  description = "Cloud Map private DNS namespace"
  type        = string
}
variable "COMMON_TAGS" {
  description = "Common tags for Cloud Map resources"
  type        = map(string)
  default     = {}
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
