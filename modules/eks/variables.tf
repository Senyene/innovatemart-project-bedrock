variable "project" {
  description = "Project name"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_endpoint_public_access" {
  type        = bool
  description = "Enable public access to the Kubernetes API"
}

variable "cluster_endpoint_private_access" {
  type        = bool
  description = "Enable private access to the Kubernetes API"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}
