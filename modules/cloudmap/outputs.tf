output "CLOUD_MAP_NAMESPACE_ID" {
  description = "Cloud Map namespace ID"
  value       = aws_service_discovery_private_dns_namespace.this_namespace.id
}
output "CLOUD_MAP_NAMESPACE_ARN" {
  description = "Cloud Map namespace ARN"
  value       = aws_service_discovery_private_dns_namespace.this_namespace.arn
}
output "CLOUD_MAP_NAMESPACE_NAME" {
  description = "Cloud Map namespace name"
  value       = aws_service_discovery_private_dns_namespace.this_namespace.name
}
output "CLOUD_MAP_SERVICE_IDS" {
  description = "Cloud Map service IDs"
  value = {
    for name, service in aws_service_discovery_service.this_service :
    name => service.id
  }
}
output "CLOUD_MAP_SERVICE_ARNS" {
  description = "Cloud Map service ARNs"
  value = {
    for name, service in aws_service_discovery_service.this_service :
    name => service.arn
  }
}
output "CLOUD_MAP_SERVICE_NAMES" {
  description = "Cloud Map service names"
  value = {
    for name, service in aws_service_discovery_service.this_service :
    name => service.name
  }
}