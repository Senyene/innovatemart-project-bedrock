module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"
  subnet_ids      = var.private_subnet_ids
  vpc_id          = var.vpc_id

  enable_irsa = true

  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  cluster_endpoint_private_access = var.cluster_endpoint_private_access

  eks_managed_node_groups = {
  default = {
    desired_capacity = 2
    max_capacity     = 3
    min_capacity     = 1

    instance_types = ["t3.medium"]

    iam_role_additional_policies = {
      AmazonEKSWorkerNodePolicy          = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
      AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      AmazonEKS_CNI_Policy               = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    }

    labels = {
      Environment = "production"
      Name        = "default"
      Project     = "Innovatemart-Bedrock-Edion"
    }

    lifecycle = {
      ignore_changes = ["labels"]
    }
  }
}

  tags = {
    Environment = "production"
    Project     = var.project
  }
}
