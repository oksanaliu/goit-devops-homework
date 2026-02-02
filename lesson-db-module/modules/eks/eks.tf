module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "lesson-db-cluster"
  cluster_version = "1.30"

  vpc_id                         = var.vpc_id
  subnet_ids                     = var.subnet_ids
  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    main = {
      instance_types = ["t3.small"]
      capacity_type  = "SPOT" 

      min_size     = 2
      max_size     = 3
      desired_size = 2
      
      iam_role_additional_policies = {
        AmazonEC2ContainerRegistryFullAccess = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
        AmazonEBSCSIDriverPolicy             = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }
    }
  }
}
