output "ALB_ID" {
  description = "Application Load Balancer ID"
  value       = aws_lb.this_load_balancer.id
}
output "ALB_ARN" {
  description = "Application Load Balancer ARN"
  value       = aws_lb.this_load_balancer.arn
}
output "ALB_DNS_NAME" {
  description = "Application Load Balancer DNS name"
  value       = aws_lb.this_load_balancer.dns_name
}
output "ALB_ZONE_ID" {
  description = "Application Load Balancer hosted zone ID"
  value       = aws_lb.this_load_balancer.zone_id
}
output "TARGET_GROUP_ID" {
  description = "Target group ID"
  value       = aws_lb_target_group.this_target_group.id
}
output "TARGET_GROUP_ARN" {
  description = "Target group ARN"
  value       = aws_lb_target_group.this_target_group.arn
}
output "LISTENER_ARN" {
  description = "ALB listener ARN"
  value       = aws_lb_listener.this_listener.arn
}