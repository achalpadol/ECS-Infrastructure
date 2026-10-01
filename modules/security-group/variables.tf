variable "VPC_ID" {
  description = "VPC ID where security groups will be created"
  type        = string
}
variable "COMMON_TAGS" {
  description = "Common tags applied to all security group resources"

  type = map(string)

  default = {}
}
variable "SECURITY_GROUPS" {
  description = "Security groups and their inbound and outbound rules"
  type = map(object({
    name        = string
    description = string
    ingress_rules = list(object({
      description                = string
      from_port                  = number
      to_port                    = number
      protocol                   = string
      cidr_ipv4                  = optional(string)
      source_security_group_name = optional(string)
    }))

    egress_rules = list(object({
      description = string
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_ipv4   = optional(string)
    }))
  }))
}