variable "ECR_REPOSITORIES" {
  description = "ECR repositories to create"
  type = map(object({
    name                 = string
    image_tag_mutability = string
    scan_on_push         = bool
  }))
}
variable "COMMON_TAGS" {
  description = "Common tags for ECR repositories"
  type        = map(string)
}