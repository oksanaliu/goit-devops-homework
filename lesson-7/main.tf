provider "aws" {
  region = "eu-west-1"
}

module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = "hw-lesson7-state-2026"
  table_name  = "terraform-locks-lesson7"
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_name           = "lesson-7-vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

module "ecr" {
  source       = "./modules/ecr"
  ecr_name     = "lesson-7-django-repo"
  scan_on_push = true
}

module "eks" {
  source       = "./modules/eks"
  cluster_name = "lesson-7-cluster"
  
  subnet_ids   = module.vpc.public_subnet_ids
}
