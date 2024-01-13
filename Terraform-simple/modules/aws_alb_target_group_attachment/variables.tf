variable "target_group_arn" {
  description = "(Required) The ARN of the target group with which to register targets."
  default     = ""
}

variable "target_id" {
}


variable "port" {
  description = "(Optional) The port on which targets receive traffic."
  default     = "80"
}

variable "availability_zone" {
  description = "(Optional) The Availability Zone where the IP address of the target is to be registered."
  default     = ""
}
