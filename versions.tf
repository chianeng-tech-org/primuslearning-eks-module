terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.35"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.13.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.3.0"
    }
  }
  required_version = ">= 1.2.5"
}
