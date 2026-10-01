output "VPC_ID" {
  description = "VPC ID"
  value       = aws_vpc.this_vpc.id
}
output "VPC_CIDR" {
  description = "VPC CIDR"
  value       = aws_vpc.this_vpc.cidr_block
}
output "PUBLIC_SUBNET_IDS" {
  description = "All public subnet IDs"
  value = [
    aws_subnet.this_public_subnet_1.id,
    aws_subnet.this_public_subnet_2.id
  ]
}
output "PRIVATE_APP_SUBNET_ID" {
  description = "Private application subnet ID"
  value       = aws_subnet.this_private_app_subnet.id
}

output "PRIVATE_DB_SUBNET_ID" {
  description = "Private database subnet ID"
  value       = aws_subnet.this_private_db_subnet.id
}
/*output "PRIVATE_APP_SUBNET_AZ" {
  description = "Private application subnet Availability Zone"
  value       = aws_subnet.this_private_app_subnet.availability_zone
}
output "PRIVATE_DB_SUBNET_AZ" {
  description = "Private database subnet Availability Zone"
  value       = aws_subnet.this_private_db_subnet.availability_zone
}
output "NAT_GATEWAY_ID" {
  description = "NAT Gateway ID"
  value       = aws_nat_gateway.this_nat_gateway.id
}*/