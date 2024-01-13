resource "aws_lb" "lb" {
  name                             = var.name
  load_balancer_type               = var.load_balancer_type
  internal                         = var.internal
  security_groups                  = var.security_groups
  subnets                          = var.subnets
  idle_timeout                     = var.idle_timeout
  enable_deletion_protection       = var.enable_deletion_protection
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  enable_http2                     = var.enable_http2
  ip_address_type                  = var.ip_address_type


  access_logs {
    bucket  = var.bucket
    enabled = var.enabled
  }

  timeouts {
    create = var.lb_create_timeout
    update = var.lb_update_timeout
    delete = var.lb_delete_timeout
  }
}
