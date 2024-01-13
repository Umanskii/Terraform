# Create route 53 to route a traffic from ALB to your domain name
resource "aws_route53_record" "dns_record" {
  zone_id = var.zone_id
  name    = var.dns_name
  type    = var.type
  ttl     = var.ttl
  records = [var.lb_dns_name]
}