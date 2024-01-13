variable "private_subnets" {
  description = "List of private subnets in the VPC."
  default     = []
}

variable "allocated_storage" {
  default = "10"
}

variable "allow_major_version_upgrade" {
  default = false
}

variable "auto_minor_version_upgrade" {
  default = false
}

variable "apply_immediately" {
  default = false
}

variable "db_subnet_group_name" {
  default = "main"
}

variable "engine" {
  default = "mysql"
}

variable "engine_version" {
  default = "5.7.37"
}

variable "instance_class" {
  default = "db.t2.micro"
}

variable "multi_az" {
  default = false
}

variable "db_name" {
  default = "wordpress"
}

variable "parameter_group_name" {
  default = "default.mysql5.7"
}

variable "publicly_accessible" {
  default = false
}

variable "skip_final_snapshot" {
  default = true
}

variable "storage_encrypted" {
  default = false
}

variable "storage_type" {
  default = "standard"
}

variable "username" {
  default = "admin"
}

variable "vpc_security_group_ids" {
  default = []
}