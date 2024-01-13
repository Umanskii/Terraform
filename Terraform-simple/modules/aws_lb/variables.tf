variable "elb_sg" {
  default = []
}
variable "subnets" {
  default = []
}
variable "instances" {
  default = []
}
variable "http_instance_port" {
  default = 80
}
variable "http_instance_protocol" {
  default = "http"
}
/*
variable "https_lb_port" {
  default = 443
}
variable "https_lb_protocol" {
  default = "https"
}
*/
variable "http_lb_port" {
  default = 80
}
variable "http_lb_protocol" {
  default = "http"
}
/*
variable "https_lb_ssl_cert" {
}
*/
variable "healthy_threshold" {
  default = 2
}
variable "unhealthy_threshold" {
  default = 2
}
variable "timeout" {
  default = 3
}
variable "http_target" {
  default = "TCP:80"
}
variable "interval" {
  default = 7
}
variable "cross_zone_load_balancing" {
  default = true
}
variable "idle_timeout" {
  default = 400
}
variable "connection_draining" {
  default = true
}
variable "connection_draining_timeout" {
  default = 400
}