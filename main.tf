terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-2"
  profile = "default"
}

# Create a key pair
# resource "aws_key_pair" "default" {
#   key_name = "default"
#   public_key = tls_private_key.rsa.public_key_openssh
# }

# resource "tls_private_key" "rsa" {
#     algorithm = "RSA"
#     rsa_bits  = 4096    
# }

# resource "local_file" "tf-key" {
#     content  = tls_private_key.rsa.private_key_pem
#     filename = "default"
# }

resource "aws_instance" "personal-server" {
  ami = "ami-0a0d9cf81c479446a"
  instance_type = "t2.micro"
  key_name = "tf-key-pair"
  tags = {
    Name = "personal-server"
  }
}

output "server_private_ip" {
    value = aws_instance.personal-server.private_ip
}

output "server_public_ip" {
    value = aws_instance.personal-server.public_ip
}
