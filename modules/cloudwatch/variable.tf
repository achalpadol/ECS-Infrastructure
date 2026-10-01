variable "LOG_GROUP_NAME" {
  type = string
}
variable "LOG_RETENTION_DAYS" {
  type = number
}
variable "COMMON_TAGS" {
  type    = map(string)
  default = {}
}