resource "aws_ecs_cluster" "this_cluster" {
  name = var.ECS_CLUSTER_NAME
  tags = merge(
    var.COMMON_TAGS,
    {
      Name = var.ECS_CLUSTER_NAME
    }
  )
}