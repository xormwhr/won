#--------------------
# Configure the AWS Provider
#--------------------

provider "aws" {

  profile = "won-aws"

  region  = "ap-northeast-2"

}

#--------------------
# VPC (aws_vpc)
#--------------------

resource "aws_vpc" "terraform_ec2_vpc_1" {

  cidr_block           = "10.0.0.0/16"

  enable_dns_support   = "true"

  enable_dns_hostnames = "true"  


  tags = {
    Name               = "terraform_ec2"
  }

}

#--------------------
# Subnet (aws_subnet)
#--------------------

resource "aws_subnet" "terraform_ec2_subnet_public_1" {

  vpc_id                  = aws_vpc.terraform_ec2_vpc_1.id

  cidr_block              = "10.0.1.0/24"

  map_public_ip_on_launch = "true"

  availability_zone       = "ap-northeast-2a"
 
  tags = {
    Name                  = "terraform_ec2"
  }

}

#----------

resource "aws_subnet" "terraform_ec2_subnet_public_2" {

  vpc_id                  = aws_vpc.terraform_ec2_vpc_1.id

  cidr_block              = "10.0.2.0/24"

  map_public_ip_on_launch = "true"

  availability_zone       = "ap-northeast-2a"
  
  tags = {
    Name                  = "terraform_ec2"
  }

}

#--------------------
# Internet Gateway (aws_internet_gateway)
#--------------------

resource "aws_internet_gateway" "terraform_ec2_internet_gateway_1" {

  vpc_id = aws_vpc.terraform_ec2_vpc_1.id

  tags = {

    Name = "terraform_ec2"

  }

}

#--------------------
# Default Route Table (aws_default_route_table)
#--------------------

resource "aws_default_route_table" "terraform_ec2_default_route_table_1" {

  default_route_table_id = aws_vpc.terraform_ec2_vpc_1.default_route_table_id

  route {

    cidr_block           = "0.0.0.0/0"

    gateway_id           = aws_internet_gateway.terraform_ec2_internet_gateway_1.id

  }


  tags = {

    Name                 = "terraform_ec2"

  }

}



#--------------------
# Route Table Association (aws_route_table_association)
#--------------------

resource "aws_route_table_association" "terraform_ec2_route_table_association_1" {

  subnet_id      = aws_subnet.terraform_ec2_subnet_public_1.id

  route_table_id = aws_default_route_table.terraform_ec2_default_route_table_1.id

}

#----------

resource "aws_route_table_association" "terraform_ec2_route_table_association_2" {

  subnet_id      = aws_subnet.terraform_ec2_subnet_public_2.id

  route_table_id = aws_default_route_table.terraform_ec2_default_route_table_1.id  

}

#--------------------
# Default Network acl (aws_default_network_acl)
#--------------------

resource "aws_default_network_acl" "terraform_ec2_default_network_acl_1" {

  default_network_acl_id = aws_vpc.terraform_ec2_vpc_1.default_network_acl_id

  ingress {

    protocol   = -1

    rule_no    = 100

    action     = "allow"

    cidr_block = "0.0.0.0/0"

    from_port  = 0

    to_port    = 0

  }

  egress {

    protocol   = -1

    rule_no    = 100

    action     = "allow"

    cidr_block = "0.0.0.0/0"

    from_port  = 0

    to_port    = 0

  }

  tags = {

    Name       = "terraform_ec2"

  }
  
}


#--------------------
# Security Group (aws_security_group)
#--------------------

resource "aws_default_security_group" "terraform_ec2_security_group_1" {

  vpc_id = aws_vpc.terraform_ec2_vpc_1.id

  ingress {

    description      = "ALL"

    protocol         = -1

    from_port        = 0

    to_port          = 0

    cidr_blocks      = ["0.0.0.0/0"]   

  }

  ingress {

    description      = "HTTPS"

    protocol         = "tcp"

    from_port        = 443

    to_port          = 443

    cidr_blocks      = ["0.0.0.0/0"]   

  }

  ingress {

    description      = "HTTP"

    protocol         = "tcp"

    from_port        = 80

    to_port          = 80

    cidr_blocks      = ["0.0.0.0/0"]   
  }

  ingress {

    description      = "SSH"

    protocol         = "tcp"

    from_port        = 22

    to_port          = 22

    cidr_blocks      = ["0.0.0.0/0"]   

  }

  egress {

    from_port        = 0

    to_port          = 0

    protocol         = "-1"

    cidr_blocks      = ["0.0.0.0/0"]

  }

  tags = {

    Name             = "terraform_ec2"

  }

}
