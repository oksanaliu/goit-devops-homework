variable "vpc_name" {
  description = "Назва VPC"
  type        = string
  default     = "lesson-8-9-vpc"
}

variable "cidr_block" {
  description = "CIDR блок для VPC"
  type        = string
  default     = "10.0.0.0/16"
}
