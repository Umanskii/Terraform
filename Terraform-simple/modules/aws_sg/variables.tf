variable "sg_name" {
  description = "(Optional, Forces new resource) The name of the security group. If omitted, Terraform will assign a random, unique name."
}

variable "sg_description" {
  description = "(Optional, Forces new resource) The security group description. Defaults to 'Managed by Terraform'."
}

variable "vpc_id" {
  description = "(Optional, Forces new resource) The VPC ID."
}
