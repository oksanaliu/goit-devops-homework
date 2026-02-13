module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "final-project-cluster"
  cluster_version = "1.30"

  vpc_id                         = var.vpc_id
  subnet_ids                     = var.subnet_ids
  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    main = {
      instance_types = ["t3.micro"] 
      capacity_type  = "ON_DEMAND" 

      min_size     = 4
      max_size     = 5
      desired_size = 4
      
      iam_role_additional_policies = {
        AmazonEC2ContainerRegistryFullAccess = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
        AmazonEBSCSIDriverPolicy             = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }
    }
  }
}
