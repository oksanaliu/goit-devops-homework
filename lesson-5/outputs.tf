output "vpc_id" {
  description = "ID створеної мережі VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Список ID публічних підмереж"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Список ID приватних підмереж"
  value       = module.vpc.private_subnet_ids
}

output "ecr_repository_url" {
  description = "URL твого Docker-репозиторію (сюди будемо пушити)"
  value       = module.ecr.repository_url
}

output "s3_bucket_name" {
  description = "Ім'я S3 бакета для стейту"
  value       = module.s3_backend.s3_bucket_name
}

output "dynamodb_table_name" {
  description = "Ім'я таблиці DynamoDB для блокування"
  value       = module.s3_backend.dynamodb_table_name
}
