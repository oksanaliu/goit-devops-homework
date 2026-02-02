terraform {
  backend "s3" {
    bucket         = "hw-lesson-db-state-2026"
    key            = "lesson-db-module/terraform.tfstate"  
    region         = "eu-west-1"
    dynamodb_table = "terraform-locks-lesson-db"
    
    encrypt        = true
  }
}
