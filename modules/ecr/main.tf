resource "aws_ecr_repository" "this_repository" {
  for_each             = var.ECR_REPOSITORIES
  name                 = each.value.name
  image_tag_mutability = each.value.image_tag_mutability
  image_scanning_configuration {
    scan_on_push = each.value.scan_on_push
  }
  encryption_configuration {
    encryption_type = "AES256"
  }
  tags = merge(
    var.COMMON_TAGS,
    {
      Name = each.value.name
    }
  )
}