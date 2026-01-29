variable "ecr_name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "scan_on_push" {
  description = "Enable automatic image scanning on push"
  type        = bool
  default     = true
}
