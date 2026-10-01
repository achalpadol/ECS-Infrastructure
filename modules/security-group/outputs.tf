output "SECURITY_GROUP_IDS" {
  description = "Security group IDs"

  value = {
    for name, security_group in aws_security_group.this_security_group :
    name => security_group.id
  }
}
output "SECURITY_GROUP_NAMES" {
  description = "Security group names"

  value = {
    for name, security_group in aws_security_group.this_security_group :
    name => security_group.name
  }
}