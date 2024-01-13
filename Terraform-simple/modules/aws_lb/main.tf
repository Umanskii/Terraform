resource "aws_elb" "elb" {
  security_groups = var.elb_sg
  subnets         = var.subnets

  listener {
    instance_port     = var.http_instance_port
    instance_protocol = var.http_instance_protocol
    lb_port           = var.http_lb_port
    lb_protocol       = var.http_lb_protocol
  }

  /*
  listener {
    instance_port     = var.http_instance_port     
    instance_protocol = var.http_instance_protocol 
    lb_port           = var.https_lb_port       
    lb_protocol       = var.https_lb_protocol       
    ssl_certificate_id = var.https_lb_ssl_cert
  }
*/
  health_check {
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.timeout
    target              = var.http_target
    interval            = var.interval
  }

  instances                   = var.instances
  cross_zone_load_balancing   = var.cross_zone_load_balancing
  idle_timeout                = var.idle_timeout
  connection_draining         = var.connection_draining
  connection_draining_timeout = var.connection_draining_timeout
}