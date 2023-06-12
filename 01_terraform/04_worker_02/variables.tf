
#--------------------
# Variables.tf
#--------------------

variable "aws_profile" {

  default = "won-aws"
  type    = string

}

variable "aws_region" {

  default = "ap-northeast-2"

}

variable "aws_az1" {

  default = "ap-northeast-2a"
  type    = string

}

variable "aws_ec2_name" {

  default = "terraform-ec2-worker-02"
  type    = string

}

variable "aws_tag_name" {

  default = "terraform-ec2-worker-02"
  type    = string

}


