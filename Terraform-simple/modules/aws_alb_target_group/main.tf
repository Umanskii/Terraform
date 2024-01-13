resource "aws_lb_target_group" "target_group" {
  name                 = var.name
  port                 = var.port
  protocol             = var.protocol
  vpc_id               = var.vpc_id
  deregistration_delay = var.deregistration_delay
  slow_start           = var.slow_start

  stickiness {
    type = var.stickiness_type
  }

  health_check {
    enabled             = var.health_check_enabled
    interval            = var.interval
    path                = var.path
    port                = var.health_check_port
    protocol            = var.health_check_protocol
    timeout             = var.timeout
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    matcher             = var.matcher
  }

  target_type = var.target_type
}
