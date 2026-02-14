output "rds_endpoint" {
  description = "The connection endpoint"
  value = var.use_aurora ? try(aws_rds_cluster.this[0].endpoint, "") : try(aws_db_instance.this[0].address, "")
}

output "rds_port" {
  value = 5432
}

output "rds_username" {
  value = var.username
}
