terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.9"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
      command     = "aws"
    }
  }
}

# --- MODULES ---

module "vpc" {
  source = "./modules/vpc"
}

module "ecr" {
  source = "./modules/ecr"
}

module "eks" {
  source          = "./modules/eks"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets
}

module "s3_backend" {
  source = "./modules/s3-backend"
}

module "jenkins" {
  source     = "./modules/jenkins"
  depends_on = [module.eks]
}

module "argo_cd" {
  source     = "./modules/argo_cd"
  namespace  = "argocd"
  depends_on = [module.eks]
}

module "rds" {
  source = "./modules/rds"

  env            = "prod"
  identifier     = "final-project-db"
  use_aurora     = false 
  
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.private_subnets
  
  db_name        = "app_db"
  username       = "postgres"
  
  password       = var.db_password 
  
  family         = "postgres14"
}

module "monitoring" {
  source     = "./modules/monitoring"
  depends_on = [module.eks] 
}