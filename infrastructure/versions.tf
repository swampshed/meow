terraform {
  required_version = "~>1.6.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.31.0"
    }
    github = {
      source = "integrations/github"
      version = "6.0.0-rc1"
    }
  }
}