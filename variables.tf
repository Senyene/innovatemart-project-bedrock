variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-west-1"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "IM-BE-Edion"
}

variable "project" {
  description = "Project name for tagging"
  type        = string
  default     = "Innovatemart-Bedrock-Edion"
}