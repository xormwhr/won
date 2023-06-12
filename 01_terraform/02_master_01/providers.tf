
#--------------------
# Providers.tf
#--------------------

#--------------------
# Configure the AWS Provider
#--------------------

terraform {

  required_version = ">= 1.3.0"

}

provider "aws" {

  profile = var.aws_profile
  region = var.aws_region

}


