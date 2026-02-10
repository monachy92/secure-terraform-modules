terraform {
  required_version = ">= 1.5.0"

  # Remote State: Stores the 'map' of your cloud in S3, not on your laptop
  backend "s3" {
    bucket         = "my-company-terraform-state" # Change to your unique bucket
    key            = "secure-modules/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table" # Prevents concurrent 'apply' crashes
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
  
  # Pro-tip: Add default tags to EVERY resource created in this project
  default_tags {
    tags = {
      Project   = "Secure-Terraform-Modules"
      ManagedBy = "Terraform"
      Owner     = "YourName"
    }
  }
}
