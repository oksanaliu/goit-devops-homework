variable "env" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "use_aurora" {
  description = "Flag to enable Aurora cluster instead of RDS instance"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "VPC ID where DB will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for DB"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of Security Groups allowed to connect to DB"
  type        = list(string)
  default     = []
}

variable "identifier" {
  description = "Identifier for the DB"
  type        = string
  default     = "my-db"
}

variable "engine" {
  description = "Database engine (postgres, mysql, aurora-postgresql)"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
  default     = "14.20" 
}

variable "instance_class" {
  description = "Instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Name of the database to create"
  type        = string
  default     = "app_db"
}

variable "username" {
  description = "Master username"
  type        = string
  default     = "adminuser"
}

variable "password" {
  description = "Master password"
  type        = string
  sensitive   = true
}

variable "family" {
  description = "DB parameter group family"
  type        = string
  default     = "postgres14"
}
