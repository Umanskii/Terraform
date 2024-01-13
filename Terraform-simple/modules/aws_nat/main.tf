### Create Elastic IP fo NAT Gateway ###
resource "aws_eip" "eip" {
  vpc      = true

  tags = {
    Name = "project-terraform-eip"
  }
}

### Create NAT gateway in public subnet ###
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = var.subnet_id

  tags = {
    Name = "project-terraform-NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  #It will wait until IGW will be created to proceed with NAT Gataway
  depends_on = [var.aws_internet_gateway]
}