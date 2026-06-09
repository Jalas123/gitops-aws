terraform {
  required_version = ">= 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Remote state in S3 with native locking (Terraform 1.10+, no DynamoDB table needed).
  # Create the bucket first, then uncomment and run: terraform init -migrate-state
  # backend "s3" {
  #   bucket       = "CHANGE-ME-gitops-tfstate"
  #   key          = "gitops-aws/infra.tfstate"
  #   region       = "eu-north-1"
  #   encrypt      = true
  #   use_lockfile = true
  # }
}
