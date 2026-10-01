variable "ECS_CLUSTER_NAME" {
  type = string
}
variable "COMMON_TAGS" {
  type    = map(string)
  default = {}
}