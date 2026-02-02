resource "aws_db_subnet_group" "this" {
  name       = "${var.identifier}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.identifier}-subnet-group"
    Env  = var.env
  }
}

resource "aws_security_group" "this" {
  name        = "${var.identifier}-sg"
  description = "Allow inbound traffic to RDS from specific SGs"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow DB traffic from App Security Groups"
    from_port       = 5432 
    to_port         = 5432
    protocol        = "tcp"
    security_groups = var.security_group_ids
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.identifier}-sg"
    Env  = var.env
  }
}
