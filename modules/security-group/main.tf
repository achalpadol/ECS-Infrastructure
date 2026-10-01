
# Security Groups
resource "aws_security_group" "this_security_group" {
  for_each    = var.SECURITY_GROUPS
  name        = each.value.name
  description = each.value.description
  vpc_id      = var.VPC_ID
  tags = merge(
    var.COMMON_TAGS,
    {
      Name = each.value.name
    }
  )
  lifecycle {
    create_before_destroy = true
  }
}
# Inbound Rules
resource "aws_vpc_security_group_ingress_rule" "this_ingress_rule" {
  for_each = {
    for rule in flatten([
      for sg_name, sg in var.SECURITY_GROUPS : [
        for index, ingress in sg.ingress_rules : {
          key                        = "${sg_name}-${index}"
          security_group_name        = sg_name
          description                = ingress.description
          from_port                  = ingress.from_port
          to_port                    = ingress.to_port
          ip_protocol                = ingress.protocol
          cidr_ipv4                  = try(ingress.cidr_ipv4, null)
          source_security_group_name = try(ingress.source_security_group_name, null)
        }
      ]
    ]) : rule.key => rule
  }

  security_group_id = aws_security_group.this_security_group[
    each.value.security_group_name
  ].id

  description = each.value.description

  from_port   = each.value.from_port
  to_port     = each.value.to_port
  ip_protocol = each.value.ip_protocol

  cidr_ipv4 = (
    each.value.source_security_group_name == null
    ? each.value.cidr_ipv4
    : null
  )

  referenced_security_group_id = (
    each.value.source_security_group_name != null
    ? aws_security_group.this_security_group[
      each.value.source_security_group_name
    ].id
    : null
  )
}
# Outbound Rules
resource "aws_vpc_security_group_egress_rule" "this_egress_rule" {
  for_each = {
    for rule in flatten([
      for sg_name, sg in var.SECURITY_GROUPS : [
        for index, egress in sg.egress_rules : {
          key                 = "${sg_name}-${index}"
          security_group_name = sg_name
          description         = egress.description
          from_port           = egress.from_port
          to_port             = egress.to_port
          ip_protocol         = egress.protocol
          cidr_ipv4           = try(egress.cidr_ipv4, null)
        }
      ]
    ]) : rule.key => rule
  }

  security_group_id = aws_security_group.this_security_group[
    each.value.security_group_name
  ].id

  description = each.value.description

  from_port   = each.value.from_port
  to_port     = each.value.to_port
  ip_protocol = each.value.ip_protocol

  cidr_ipv4 = each.value.cidr_ipv4
}