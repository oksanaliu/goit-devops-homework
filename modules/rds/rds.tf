resource "aws_db_parameter_group" "rds" {
  count  = var.use_aurora ? 0 : 1
  name   = "${var.identifier}-pg"
  family = var.family

  parameter {
    name  = "log_statement"
    value = "all"
  }
}

resource "aws_db_instance" "this" {
  count = var.use_aurora ? 0 : 1

  identifier             = var.identifier
  engine                 = "postgres"
  engine_version         = "14"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  
  db_name                = var.db_name
  username               = var.username
  password               = var.password
  
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.this.id]
  parameter_group_name   = aws_db_parameter_group.rds[0].name

  skip_final_snapshot    = true
  publicly_accessible    = true
  
  tags = {
    Name = "${var.identifier}-instance"
    Env  = var.env
  }
}
