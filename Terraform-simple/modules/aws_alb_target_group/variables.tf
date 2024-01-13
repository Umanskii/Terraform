variable "name" {
  description = "(Optional, Forces new resource) The name of the target group. If omitted, Terraform will assign a random, unique name."
  default     = ""
}

variable "port" {
  description = "(Optional, Forces new resource) The port on which targets receive traffic, unless overridden when registering a specific target. Required when target_type is instance or ip. Does not apply when target_type is lambda."
  default     = "80"
}

variable "protocol" {
  description = "(Optional, Forces new resource) The protocol to use for routing traffic to the targets. Should be one of 'TCP', 'TLS', 'UDP', 'TCP_UDP', 'HTTP' or 'HTTPS'. Required when target_type is instance or ip. Does not apply when target_type is lambda."
  default     = "HTTP"
}

variable "vpc_id" {
  description = "(Optional, Forces new resource) The identifier of the VPC in which to create the target group. Required when target_type is instance or ip. Does not apply when target_type is lambda."
  default     = ""
}

variable "deregistration_delay" {
  description = "(Optional) The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds. The default value is 300 seconds."
  default     = "300"
}

variable "slow_start" {
  description = "(Optional) The amount time for targets to warm up before the load balancer sends them a full share of requests. The range is 30-900 seconds or 0 to disable. The default value is 0 seconds."
  default     = 0
}

variable "stickiness_type" {
  description = "(Required) The type of sticky sessions. The only current possible value is lb_cookie."
  default     = "lb_cookie"
}

variable "health_check_enabled" {
  description = "(Optional) Indicates whether health checks are enabled. Defaults to true."
  default     = true
}

variable "interval" {
  description = "(Optional) The approximate amount of time, in seconds, between health checks of an individual target. Minimum value 5 seconds, Maximum value 300 seconds."
  default     = "30"
}

variable "path" {
  description = "(Required for HTTP/HTTPS ALB) The destination for the health check request. Applies to Application Load Balancers only (HTTP/HTTPS), not Network Load Balancers (TCP)."
  default     = "/"
}

variable "health_check_port" {
  description = "(Optional) The port to use to connect with the target. Valid values are either ports 1-65536, or traffic-port. Defaults to traffic-port."
  default     = "traffic-port"
}

variable "health_check_protocol" {
  description = "(Optional) The protocol to use to connect with the target. Defaults to HTTP. Not applicable when target_type is lambda."
  default     = "HTTP"
}

variable "timeout" {
  description = "(Optional) The amount of time, in seconds, during which no response means a failed health check."
  default     = "10"
}

variable "healthy_threshold" {
  description = "(Optional) The number of consecutive health checks successes required before considering an unhealthy target healthy. Defaults to 3."
  default     = "3"
}

variable "unhealthy_threshold" {
  description = " (Optional) The number of consecutive health check failures required before considering the target unhealthy ."
  default     = "3"
}

variable "matcher" {
  description = "(Required for HTTP/HTTPS ALB) The HTTP codes to use when checking for a successful response from a target."
  default     = "200-399"
}

variable "target_type" {
  description = "(Optional, Forces new resource) The type of target that you must specify when registering targets with this target group."
  default     = "instance"
}

