# Cloud Map Namespace
resource "aws_service_discovery_private_dns_namespace" "this_namespace" {
  name = var.CLOUD_MAP_NAMESPACE
  # description = "Private Cloud Map namespace for ${var.ENVIRONMENT}"
  vpc = var.VPC_ID
  tags = merge(
    var.COMMON_TAGS,
    {
      Name = var.CLOUD_MAP_NAMESPACE
    }
  )
}
# Cloud Map Services
resource "aws_service_discovery_service" "this_service" {
  for_each     = var.CLOUD_MAP_SERVICES
  name         = each.value.name
  namespace_id = aws_service_discovery_private_dns_namespace.this_namespace.id
  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.this_namespace.id
    dns_records {
      ttl  = each.value.ttl
      type = "A"
    }
    routing_policy = each.value.routing_policy
  }
  health_check_custom_config {
    failure_threshold = each.value.failure_threshold
  }
  tags = merge(
    var.COMMON_TAGS,
    {
      Name = each.value.name
    }
  )
}