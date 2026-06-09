variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-north-1" # Stockholm — matches your existing EC2
}

variable "project" {
  description = "Project name, used for tagging and resource naming"
  type        = string
  default     = "gitops-aws"
}

variable "cluster_version" {
  description = "EKS Kubernetes version. Confirm it's currently supported: aws eks describe-cluster-versions"
  type        = string
  default     = "1.32"
}
