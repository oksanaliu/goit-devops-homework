variable "bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  default     = "final-project-state-2026"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for state locking"
  default     = "terraform-locks-final-project"
}
