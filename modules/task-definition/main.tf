
# FRONTEND TASK DEFINITION
resource "aws_ecs_task_definition" "this_frontend_task_definition" {
  family                   = var.FRONTEND_TASK_FAMILY
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.FRONTEND_CPU
  memory                   = var.FRONTEND_MEMORY
  execution_role_arn       = var.ECS_EXECUTION_ROLE_ARN
  container_definitions = jsonencode([
    {
      name      = "frontend"
      image     = var.FRONTEND_IMAGE
      essential = true
      command = [
        "-listen=:8000",
        "-text=Hello from Frontend ECS"
      ]
      portMappings = [
        {
          containerPort = var.FRONTEND_CONTAINER_PORT
          hostPort      = var.FRONTEND_CONTAINER_PORT
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = var.LOG_GROUP_NAME
          awslogs-region        = var.AWS_REGION
          awslogs-stream-prefix = "frontend"
        }
      }
    }
  ])
  tags = merge(
    var.COMMON_TAGS,
    {
      Name = var.FRONTEND_TASK_FAMILY
    }
  )
}
# BACKEND TASK DEFINITION
resource "aws_ecs_task_definition" "this_backend_task_definition" {
  family                   = var.BACKEND_TASK_FAMILY
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.BACKEND_CPU
  memory                   = var.BACKEND_MEMORY
  execution_role_arn       = var.ECS_EXECUTION_ROLE_ARN
  container_definitions = jsonencode([
    {
      name      = "backend"
      image     = var.BACKEND_IMAGE
      essential = true

      command = [
        "-listen=:8000",
        "-text=Hello from Backend ECS"
      ]
      portMappings = [
        {
          containerPort = var.BACKEND_CONTAINER_PORT
          hostPort      = var.BACKEND_CONTAINER_PORT
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.LOG_GROUP_NAME
          awslogs-region        = var.AWS_REGION
          awslogs-stream-prefix = "backend"
        }
      }
    }
  ])
  tags = merge(
    var.COMMON_TAGS,
    {
      Name = var.BACKEND_TASK_FAMILY
    }
  )
}
# DATABASE TASK DEFINITION
resource "aws_ecs_task_definition" "this_db_task_definition" {
  family                   = var.DB_TASK_FAMILY
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.DB_CPU
  memory                   = var.DB_MEMORY
  execution_role_arn       = var.ECS_EXECUTION_ROLE_ARN
  container_definitions = jsonencode([
    {
      name      = "db"
      image     = var.DB_IMAGE
      essential = true
      portMappings = [
        {
          containerPort = var.DB_CONTAINER_PORT
          hostPort      = var.DB_CONTAINER_PORT
          protocol      = "tcp"
        }
      ]
      //environment = [
        //{
         // name  = "POSTGRES_PASSWORD"
         // value = var.DB_PASSWORD
       // },
       // {
         // name  = "POSTGRES_DB"
         // value = var.DB_NAME
        //}
     // ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.LOG_GROUP_NAME
          awslogs-region        = var.AWS_REGION
          awslogs-stream-prefix = "db"
        }
      }
    }
  ])
  tags = merge(
    var.COMMON_TAGS,
    {
      Name = var.DB_TASK_FAMILY
    }
  )
}
