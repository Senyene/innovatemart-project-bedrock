module "vpc" {
  source              = "./modules/vpc"
  project             = "Innovatemart-Bedrock-Edion"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  azs                 = ["eu-west-1a", "eu-west-1b"]
}

module "eks" {
  source             = "./modules/eks"
  project            = var.project
  cluster_name       = "IM-BE-Edion"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = false
}

module "developer_access" {
  source    = "./modules/iam-dev-access"
  user_name = "innovatemart-dev"
}
