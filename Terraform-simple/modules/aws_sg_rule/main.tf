resource "aws_security_group_rule" "rule" {
  type                     = var.type
  cidr_blocks              = var.cidr_blocks
  from_port                = var.from_port
  to_port                  = var.to_port
  protocol                 = var.protocol
  description              = var.description
  security_group_id        = var.security_group_id
}
