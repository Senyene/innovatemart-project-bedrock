terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source               = "./modules/vpc"
  project              = var.project
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  azs                  = ["eu-west-1a", "eu-west-1b"]
}

resource "aws_cloudwatch_log_group" "eks_cluster" {
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = 30

 #  lifecycle {
 #   prevent_destroy = true
 #  ignore_changes = [
 #     retention_in_days,
 #     tags,
 #   ]
 # }

  tags = {
    Environment = "production"
    Project     = var.project
  }
}

module "eks" {
  source             = "./modules/eks"
  project            = var.project
  cluster_name       = var.cluster_name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = false
  region                          = var.region
}

resource "aws_iam_user" "developer" {
  name = "innovatemart-dev"

 # lifecycle {
 #   prevent_destroy = true
 # }
}

data "aws_iam_policy_document" "eks_readonly" {
  statement {
    actions   = ["eks:Describe*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "eks_readonly" {
  name   = "EKSReadOnlyAccess"
  policy = data.aws_iam_policy_document.eks_readonly.json

 # lifecycle {
 #  prevent_destroy = true
 # }
}

module "developer_access" {
  source    = "./modules/iam-dev-access"
  user_name = aws_iam_user.developer.name
}

# Example change
# This is a test comment for CI/CD