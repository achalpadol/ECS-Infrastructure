
# Application Load Balancer
resource "aws_lb" "this_load_balancer" {
  name               = var.ALB_NAME
  internal           = false
  load_balancer_type = "application"
  security_groups = [
    var.ALB_SECURITY_GROUP_ID
  ]
  subnets                    = var.PUBLIC_SUBNET_IDS
  enable_deletion_protection = var.ENABLE_DELETION_PROTECTION
  tags = merge(
    var.COMMON_TAGS,
    {
      Name = var.ALB_NAME
    }
  )
}
# Target Group
resource "aws_lb_target_group" "this_target_group" {
  name        = var.TARGET_GROUP_NAME
  port        = var.TARGET_GROUP_PORT
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.VPC_ID
  health_check {
    enabled             = true
    path                = var.HEALTH_CHECK_PATH
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200-399"
  }
  tags = merge(
    var.COMMON_TAGS,
    {
      Name = var.TARGET_GROUP_NAME
    }
  )
}
# ALB Listener
resource "aws_lb_listener" "this_listener" {
  load_balancer_arn = aws_lb.this_load_balancer.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this_target_group.arn
  }
  tags = merge(
    var.COMMON_TAGS,
    {
      Name = "${var.ALB_NAME}-listener"
    }
  )
}