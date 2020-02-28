provider "aws" {
region ="us-west-1"
access_key = "AKIAV4FHZIXXDWVXAE4R"
secret_key = "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"
}

resource "aws_vpc" "twVPC" {
  cidr_block       ="10.0.0.0/16"
  tags = {
    Name = "twVPC"
  }
}

resource "aws_subnet" "twpublicsubnet" {
  vpc_id     = aws_vpc.twVPC.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "twpublicsubnet" 
  }
}

resource "aws_subnet" "twprivatesubnet1" {
  vpc_id     = aws_vpc.twVPC.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "twprivatesubnet1" 
  }
}

resource "aws_subnet" "twprivatesubnet2" {
  vpc_id     = aws_vpc.twVPC.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "twprivatesubnet2" 
  }
}

resource "aws_internet_gateway" "twigw" {
  vpc_id = aws_vpc.twVPC.id

  tags = {
    Name = "twigw"
  }
}


resource "aws_route_table" "twroute" {
  vpc_id = aws_vpc.twVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.twigw.id
  }
 
  tags = {
    Name = "twroute"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.twpublicsubnet.id
  route_table_id = aws_route_table.twroute.id
}

resource "aws_security_group" "TWSG" {

 name          = "TWSG"
  vpc_id = aws_vpc.twVPC.id
  ingress {
           from_port      = 8081
           to_port        = 8081
           protocol       = "tcp"
	   cidr_blocks = ["0.0.0.0/0"]
           
          }
    ingress {
           from_port      = 8082
           to_port        = 8082
           protocol       = "tcp"
	   cidr_blocks = ["0.0.0.0/0"]
          }
  ingress {
      from_port           = 22
      to_port             = 22
      protocol            = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ingress {
    from_port             = 8080
    to_port               = 8080
    protocol              = "tcp"
    cidr_blocks           = ["0.0.0.0/0"]
  }
	ingress {
    from_port             = 9091
    to_port               = 9091
    protocol              = "tcp"
    cidr_blocks           = ["0.0.0.0/0"]
  }
  egress {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
         }
   tags = {
    Name = "TWSG"
  }
}
