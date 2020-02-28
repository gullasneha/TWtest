module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"
  ami                    = "ami-01c94064639c71719"
  instance_type          = "t2.micro"
  instance 		 = 2
  name                   = "twec2"
  
  vpc_security_group_ids = ["sg-0ec878d53f19307a3"]
  subnet_id              = "subnet-0754c0403c263f982"

  tags = {
    Terraform   = "true"
    Environment = "test"
  }
}
