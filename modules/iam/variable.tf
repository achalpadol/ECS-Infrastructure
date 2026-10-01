variable "ECS_EXECUTION_ROLE_NAME" {
  type = string
}
variable "COMMON_TAGS" {
  type    = map(string)
  default = {}
}