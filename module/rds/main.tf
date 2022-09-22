resource "aws_db_instance" "database1" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  name                 = var.dbname
  username             = var.username
  password             = var.password
  availability_zone = "us-east-1a"
  db_subnet_group_name = aws_db_subnet_group.rds_sub_grp.name
  vpc_security_group_ids = [var.rds-sg-id]
#   parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}

//rds subnet group
resource "aws_db_subnet_group" "rds_sub_grp" {
  name       = "rds_snets"
  subnet_ids = [var.rds-snet1,var.rds-snet2]

  tags = {
    Name = "My DB subnet group"
  }
}


