data "aws_secretsmanager_secret_version" "creds" {
  secret_id = "rds_secret"
}

locals {
  rds_creds = jsondecode(
    data.aws_secretsmanager_secret_version.creds.secret_string
  )
}

resource "aws_db_subnet_group" "subnet-group" {
  subnet_ids = var.private_subnets
}

resource "aws_db_instance" "db" {
  allocated_storage           = var.allocated_storage
  allow_major_version_upgrade = var.allow_major_version_upgrade
  apply_immediately           = var.apply_immediately
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  db_subnet_group_name        = aws_db_subnet_group.subnet-group.name
  engine                      = var.engine
  engine_version              = var.engine_version
  instance_class              = var.instance_class
  multi_az                    = var.multi_az
  db_name                     = var.db_name
  parameter_group_name        = var.parameter_group_name
  password                    = local.rds_creds.rdssecret
  publicly_accessible         = var.publicly_accessible
  skip_final_snapshot         = var.skip_final_snapshot
  storage_encrypted           = var.storage_encrypted
  storage_type                = var.storage_type
  username                    = var.username
  vpc_security_group_ids      = var.vpc_security_group_ids
}
