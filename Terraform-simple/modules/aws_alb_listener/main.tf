resource "aws_lb_listener" "listener" {
  load_balancer_arn = var.load_balancer_arn
  port              = var.port
  protocol          = var.protocol
  default_action {
    type             = var.type
    target_group_arn = var.target_group_arn
  }
}