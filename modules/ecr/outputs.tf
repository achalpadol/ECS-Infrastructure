output "ECR_REPOSITORY_URLS" {
  description = "ECR repository URLs"
  value = {
    for name, repository in aws_ecr_repository.this_repository :
    name => repository.repository_url
  }
}
output "ECR_REPOSITORY_ARNS" {
  description = "ECR repository ARNs"
  value = {
    for name, repository in aws_ecr_repository.this_repository :
    name => repository.arn
  }
}
output "ECR_REPOSITORY_NAMES" {
  description = "ECR repository names"
  value = {
    for name, repository in aws_ecr_repository.this_repository :
    name => repository.name
  }
}