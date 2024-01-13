variable "cidr_block" {
  description = "(Required) The CIDR block for the subnet."
  default     = []
}

variable "az" {
  description = "(Optional) The AZ for the subnet."
}

variable "map_public_ip_on_launch" {
  description = " (Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is false. "
  default     = false
}

variable "assign_ipv6_address_on_creation" {
  description = "(Optional) Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address. Default is false."
  default     = false
}

variable "vpc_id" {
  description = "(Required) The VPC ID."
}