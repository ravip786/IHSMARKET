provider "aws" {
  region  = var.region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
  /* backend "s3" {
    bucket  = "grupdev-tfstate-prod-033333781728"
    key     = "root/terraform.tfstate"
    region  = "us-east-1"
    dynamodb_table = "grupdev-tfstate-lock-prod-033333781728"
  }   */
  