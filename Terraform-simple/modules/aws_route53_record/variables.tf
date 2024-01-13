variable "lb_dns_name" {
  description = "(Required) ALB DNS name"
}

variable "zone_id" {
}

variable "dns_name" {
}

variable "type" {
  default = "CNAME"
}

variable "ttl" {
  default = "300"
}

