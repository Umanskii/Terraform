#Create VPC
module "vpc" {
  source    = "./modules/aws_vpc"
  vpc_block = "10.62.0.0/24"
}

#Create IGW
module "internet-gateway" {
  source = "./modules/aws_igw"
  vpc_id = module.vpc.id
}

#Create subnets
module "public-subnet1" {
  source         = "./modules/aws_public_subnet"
  vpc_id         = module.vpc.id
  cidr_block     = "10.62.0.0/26"
  az             = "us-east-1a"
  route_table_id = module.route-table.id
}

module "public-subnet2" {
  source         = "./modules/aws_public_subnet"
  vpc_id         = module.vpc.id
  cidr_block     = "10.62.0.64/26"
  az             = "us-east-1b"
  route_table_id = module.route-table.id
}

module "private-subnet1" {
  source     = "./modules/aws_private_subnet"
  vpc_id     = module.vpc.id
  cidr_block = "10.62.0.128/26"
  az         = "us-east-1a"
}

module "private-subnet2" {
  source     = "./modules/aws_private_subnet"
  vpc_id     = module.vpc.id
  cidr_block = "10.62.0.192/26"
  az         = "us-east-1b"
}

#Create route table
module "route-table" {
  source = "./modules/aws_route_table"
  vpc_id = module.vpc.id
}

#Create routes
module "route" {
  source         = "./modules/aws_route"
  route_table_id = module.route-table.id
  gateway_id     = module.internet-gateway.id
}

##If you wanna install NAT
/*
#Create public route table
module "route-table-public" {
  source = "./modules/aws_route_table"
  vpc_id = module.vpc.id
}

#Create public routes to IGW
module "route-igw" {
  source         = "./modules/aws_route"
  route_table_id = module.route-table-public.id
  gateway_id     = module.internet-gateway.id
}

#Create NAT Gateway
module "nat-gateway" {
  source                = "./modules/aws_nat"
  subnet_id             = module.public-subnet1.id ### first public subnet
  aws_internet_gateway  = module.internet-gateway.id
}

#Create private route table
module "route-table-private" {
  source = "./modules/aws_route_table"
  vpc_id = module.vpc.id
}

#Create private routes to NAT Gateway
module "route-nat" {
  source         = "./modules/aws_route"
  route_table_id = module.route-table-private.id
  gateway_id     = module.nat-gateway.id
}
*/

#Create security groups and rules
#--------------------------------------------------------------------
#Security group web

module "sg-ec2" {
  source         = "./modules/aws_sg"
  vpc_id         = module.vpc.id
  sg_name        = "ec2_ssh"
  sg_description = "EC2 SSH access"
}

#Ingress rules
module "sg-ec2-ssh-ingress-rules" {
  source            = "./modules/aws_sg_rule"
  security_group_id = module.sg-ec2.security_group_id
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "ingress"
  from_port         = "22"
  to_port           = "22"
  protocol          = "TCP"
  description       = "Open SSH access to the world"
}


module "sg-ec2-from-alb-ingress-rules" {
  source                   = "./modules/aws_sg_rule_source_id"
  security_group_id        = module.sg-ec2.security_group_id
  source_security_group_id = module.sg-elb.security_group_id
  type                     = "ingress"
  from_port                = "80"
  to_port                  = "80"
  protocol                 = "TCP"
  description              = "Open port 80 to the ELBs security group"
}


#Egress rule (terraform does not do this by default)
module "sg-ec2-egress-rules" {
  source            = "./modules/aws_sg_rule"
  type              = "egress"
  security_group_id = module.sg-ec2.security_group_id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "0"
  to_port           = "65535"
  protocol          = "TCP"
  description       = "Allow all outbound"
}


#Security group ALB
module "sg-elb" {
  source         = "./modules/aws_sg"
  vpc_id         = module.vpc.id
  sg_name        = "elb_sg"
  sg_description = "ELB security group"
}

#Ingress rules
module "sg-elb-ingress-rules" {
  source            = "./modules/aws_sg_rule"
  type              = "ingress"
  security_group_id = module.sg-elb.security_group_id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "80"
  to_port           = "80"
  protocol          = "TCP"
  description       = "Open port 80 to the world"
}

#Egress rule (terraform does not do this by default)
module "sg-elb-egress-rules" {
  source            = "./modules/aws_sg_rule"
  type              = "egress"
  security_group_id = module.sg-elb.security_group_id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "0"
  to_port           = "65535"
  protocol          = "TCP"
  description       = "Allow all outbound"
}

#Security group RDS
module "sg-rds" {
  source         = "./modules/aws_sg"
  vpc_id         = module.vpc.id
  sg_name        = "rds_sg"
  sg_description = "RDS security group"
}

#Ingress rules
module "sg-rds-ingress-rules" {
  source            = "./modules/aws_sg_rule"
  type              = "ingress"
  security_group_id = module.sg-rds.security_group_id
  cidr_blocks       = [module.public-subnet1.cidr_block, module.public-subnet2.cidr_block]
  from_port         = "3306"
  to_port           = "3306"
  protocol          = "TCP"
  description       = "Open RDS on port 3306 to private subnets"
}

#Egress rule (terraform does not do this by default)
module "sg-rds-egress-rules" {
  source            = "./modules/aws_sg_rule"
  type              = "egress"
  security_group_id = module.sg-rds.security_group_id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "0"
  to_port           = "65535"
  protocol          = "TCP"
  description       = "Allow all outbound"
}


#Create EC2 instances
#--------------------------------------------------------------------------------------------------------------
#Get Linux AMI ID using SSM Parameter endpoint in us-east-1
data "aws_ssm_parameter" "linuxAmi" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

#Create key-pair for logging into EC2
module "key_pair" {
  source     = "./modules/aws_key_pair"
  key_name   = "public-ssh"
  public_key = file("~/.ssh/id_rsa.pub")
}

module "ec2_instance1" {
  source                 = "./modules/aws_ec2"
  ami                    = data.aws_ssm_parameter.linuxAmi.value
  key_name               = module.key_pair.id
  vpc_security_group_ids = [module.sg-ec2.security_group_id]
  subnet_id              = module.public-subnet1.id
}

module "ec2_instance2" {
  source                 = "./modules/aws_ec2"
  ami                    = data.aws_ssm_parameter.linuxAmi.value
  key_name               = module.key_pair.id
  vpc_security_group_ids = [module.sg-ec2.security_group_id]
  subnet_id              = module.public-subnet2.id
}

module "rds" {
  source                 = "./modules/aws_rds"
  private_subnets        = [module.private-subnet1.id, module.private-subnet2.id]
  vpc_security_group_ids = [module.sg-rds.security_group_id]
}

#Create ALB
module "alb" {
  source          = "./modules/aws_alb"
  name            = "projectALB"
  subnets         = [module.public-subnet1.id, module.public-subnet2.id]
  security_groups = [module.sg-elb.security_group_id]
}

#load balancer Target Group
module "alb-target-group" {
  source   = "./modules/aws_alb_target_group"
  name     = "projectALBtg"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = module.vpc.id
}

#load balancer Target Group Attach
module "alb-target-group-www-attach-ec1" {
  source           = "./modules/aws_alb_target_group_attachment"
  target_group_arn = module.alb-target-group.arn
  target_id        = module.ec2_instance1.id
}

module "alb-target-group-www-attach-ec2" {
  source           = "./modules/aws_alb_target_group_attachment"
  target_group_arn = module.alb-target-group.arn
  target_id        = module.ec2_instance2.id
}

#load balancer Listener
module "alb-www-public-listener-80" {
  source            = "./modules/aws_alb_listener"
  load_balancer_arn = module.alb.arn
  port              = "80"
  protocol          = "HTTP"
  type              = "forward"
  target_group_arn  = module.alb-target-group.arn
}

#Create a CNAME record in Route 53 to map ALBs DNS to your domain name
module "route53_record" {
  source      = "./modules/aws_route53_record"
  lb_dns_name = module.alb.alb_dns
  dns_name    = "ansible.umanskiisd.com" #replace with your dns name
  zone_id     = "Z08463342O6BQREC1IJ6T"  #replace with your zone id 
}

