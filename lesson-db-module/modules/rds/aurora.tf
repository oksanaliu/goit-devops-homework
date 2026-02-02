resource "aws_rds_cluster_parameter_group" "aurora" {
  count  = var.use_aurora ? 1 : 0
  name   = "${var.identifier}-aurora-pg"
  family = var.family 

  parameter {
    name  = "log_statement"
    value = "all"
    apply_method = "immediate"
  }
  
  parameter {
    name         = "work_mem"
    value        = "4096"
    apply_method = "pending-reboot"
  }
}

resource "aws_rds_cluster" "this" {
  count = var.use_aurora ? 1 : 0

  cluster_identifier      = "${var.identifier}-cluster"
  engine                  = var.engine        
  engine_version          = var.engine_version
  database_name           = var.db_name
  master_username         = var.username
  master_password         = var.password
  
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [aws_security_group.this.id]
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora[0].name

  skip_final_snapshot     = true
}

resource "aws_rds_cluster_instance" "this" {
  count              = var.use_aurora ? 1 : 0
  
  identifier         = "${var.identifier}-aurora-node-${count.index}"
  cluster_identifier = aws_rds_cluster.this[0].id
  instance_class     = var.instance_class
  engine             = aws_rds_cluster.this[0].engine
  engine_version     = aws_rds_cluster.this[0].engine_version
  
  publicly_accessible = false
}
