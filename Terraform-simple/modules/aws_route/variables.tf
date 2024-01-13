variable "route_table_id" {
  description = "(Required) The ID of the routing table."
}

variable "destination_cidr_block" {
  description = "(Optional) The destination CIDR block."
  default     = "0.0.0.0/0"
}

variable "gateway_id" {
  description = "(Optional) Identifier of a VPC internet gateway or a virtual private gateway."
  default     = ""
}

