provider "aws" {
  region = "eu-north-1"
}

resource "aws_security_group" "lab_sg" {
  name = "lab6-security-group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "lab6_instance" {
  ami           = "ami-0c1ac8a41498c1a9c"
  instance_type = "t3.micro"
  key_name      = "lab4-key"

  vpc_security_group_ids = [aws_security_group.lab_sg.id]

  tags = {
    Name = "Lab-Terraform-Instance"
  }
}

output "public_ip" {
  value = aws_instance.lab6_instance.public_ip
}
