terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

#AWS EC2
provider "aws" {
  region     = "ap-southeast-2"
}

resource "aws_security_group" "allow_tls" {
  name        = "security_allow_all"
  description = "Allow TLS inbound traffic"
  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }

}

#Instance
resource "aws_instance" "cilsy" {
  ami           = "ami-0310483fb2b488153" 
  instance_type = "t2.micro"  
  key_name      = "sydney-03"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  tags = {
    Name = "Cilist"
  }
}
