terraform {
  backend "s3" {
    bucket = "elias-brange-ci-cd"
    key    = "terraform/aws-github-actions-oidc.tfstate"
    region = "eu-west-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.2.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}
