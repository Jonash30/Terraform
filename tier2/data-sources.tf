
data "aws_availability_zones" "available" {
}

data "aws_region" "current" {
}

#define vpc
data "aws_vpc" "default" {
  default = true
}

data "aws_key_pair" "terraform_key" {
  key_name = "terraform_key"
}

variable "private_subnets" {
  default = {
    tier_2 = 250
  }
}
