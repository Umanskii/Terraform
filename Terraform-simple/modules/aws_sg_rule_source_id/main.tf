resource "aws_security_group_rule" "rule" {
  type                     = var.type
  source_security_group_id = var.source_security_group_id
  from_port                = var.from_port
  to_port                  = var.to_port
  protocol                 = var.protocol
  description              = var.description
  security_group_id        = var.security_group_id
}
