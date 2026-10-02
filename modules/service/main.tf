# FRONTEND ECS SERVICE
resource "aws_ecs_service" "this_frontend_service" {
  name             = var.FRONTEND_SERVICE_NAME
  cluster          = var.ECS_CLUSTER_ARN
  task_definition  = var.FRONTEND_TASK_DEFINITION_ARN
  desired_count    = var.FRONTEND_DESIRED_COUNT
  launch_type      = "FARGATE"
  platform_version = "LATEST"
  network_configuration {
    subnets = var.PRIVATE_APP_SUBNET_IDS
    security_groups = [
      var.ECS_SECURITY_GROUP_ID
    ]
    assign_public_ip = false
  }
  load_balancer {
    target_group_arn = var.TARGET_GROUP_ARN
    container_name   = "frontend"
    container_port   = var.FRONTEND_CONTAINER_PORT
  }
  tags = merge(
    var.COMMON_TAGS,
    {
      Name = var.FRONTEND_SERVICE_NAME
    }
  )
}
# BACKEND ECS SERVICE
resource "aws_ecs_service" "this_backend_service" {
  name             = var.BACKEND_SERVICE_NAME
  cluster          = var.ECS_CLUSTER_ARN
  task_definition  = var.BACKEND_TASK_DEFINITION_ARN
  desired_count    = var.BACKEND_DESIRED_COUNT
  launch_type      = "FARGATE"
  platform_version = "LATEST"
  network_configuration {
    subnets = var.PRIVATE_APP_SUBNET_IDS
    security_groups = [
      var.ECS_SECURITY_GROUP_ID
    ]
    assign_public_ip = false
  }
  service_registries {
    registry_arn = var.BACKEND_CLOUD_MAP_SERVICE_ARN
  }
  tags = merge(
    var.COMMON_TAGS,
    {
      Name = var.BACKEND_SERVICE_NAME
    }
  )
}
# DATABASE ECS SERVICE
resource "aws_ecs_service" "this_db_service" {
  name             = var.DB_SERVICE_NAME
  cluster          = var.ECS_CLUSTER_ARN
  task_definition  = var.DB_TASK_DEFINITION_ARN
  desired_count    = var.DB_DESIRED_COUNT
  launch_type      = "FARGATE"
  platform_version = "LATEST"
  network_configuration {
    subnets = var.PRIVATE_APP_SUBNET_IDS
    security_groups = [
      var.DB_SECURITY_GROUP_ID
    ]
    assign_public_ip = false
  }
  service_registries {
    registry_arn = var.DB_CLOUD_MAP_SERVICE_ARN
  }
  tags = merge(
    var.COMMON_TAGS,
    {
      Name = var.DB_SERVICE_NAME
    }
  )
}
