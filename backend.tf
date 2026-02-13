terraform {
  backend "s3" {
    bucket         = "final-project-state-2026" 
    key            = "final-project/terraform.tfstate"
    region         = "eu-west-1"
    
    dynamodb_table = "terraform-locks-final-project"
    
    encrypt        = true
  }
}
