variable "vpc_name" {
  description = "Назва VPC"
  type        = string
  default     = "final-project-vpc"
}

variable "cidr_block" {
  description = "CIDR блок для VPC"
  type        = string
  default     = "10.0.0.0/16"
}
