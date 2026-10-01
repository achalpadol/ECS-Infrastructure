resource "aws_iam_role" "this_ecs_execution_role" {
  name = var.ECS_EXECUTION_ROLE_NAME

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(
    var.COMMON_TAGS,
    {
      Name = var.ECS_EXECUTION_ROLE_NAME
    }
  )
}

resource "aws_iam_role_policy_attachment" "this_ecs_execution_policy" {
  role = aws_iam_role.this_ecs_execution_role.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}