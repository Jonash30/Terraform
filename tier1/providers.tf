terraform {
  required_version = ">= 1.3.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.71.0"
    }
  }
}

provider "aws" {
  region  = "ap-northeast-1"
  profile = "terraform_user"
}
//provider "aws" {
# Configuration options
//}
