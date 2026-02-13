resource "aws_rds_cluster_parameter_group" "aurora" {
  count  = var.use_aurora ? 1 : 0
  name   = "${var.identifier}-aurora-pg"
  family = "aurora-postgresql14"
}

resource "aws_rds_cluster" "this" {
  count = var.use_aurora ? 1 : 0

  cluster_identifier      = "${var.identifier}-cluster"
  engine                  = "aurora-postgresql"
  master_username         = var.username
  master_password         = var.password
  skip_final_snapshot     = true
}

resource "aws_rds_cluster_instance" "this" {
  count              = var.use_aurora ? 1 : 0
  
  identifier         = "${var.identifier}-aurora-node-${count.index}"
  cluster_identifier = aws_rds_cluster.this[0].id
  instance_class     = "db.r5.large"
  engine             = aws_rds_cluster.this[0].engine
}
