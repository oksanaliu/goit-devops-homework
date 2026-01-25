terraform {
  backend "s3" {
    bucket         = "hw-lesson7-state-2026"
    key            = "lesson-7/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-locks-lesson7"
    encrypt        = true
  }
}
