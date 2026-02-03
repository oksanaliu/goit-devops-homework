variable "bucket_name" {
  default = "hw-lesson-db-state-2026"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for state locking"
  default     = "terraform-locks-lesson-db"
}
