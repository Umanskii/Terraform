resource "aws_subnet" "subnets" {
  availability_zone               = var.az
  cidr_block                      = var.cidr_block
  map_public_ip_on_launch         = var.map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation
  vpc_id                          = var.vpc_id
}
