
#--------------------
# EC2 Module
#--------------------

# https://github.com/terraform-aws-modules/terraform-aws-ec2-instance

module "ec2_instance" {

  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = var.aws_ec2_name

  ami                    = "ami-004b403708f61ecd8"
  instance_type          = "t2.medium"
  key_name               = "won-key"
  monitoring             = false
  vpc_security_group_ids = ["sg-093bae93b27a514fb"]
  subnet_id              = "subnet-054f5946b6c8a2349"
  availability_zone      = var.aws_az1
 
  tags = {
    Terraform   = "true"
    Name        = var.aws_tag_name
  }

}

