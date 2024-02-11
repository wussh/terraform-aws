terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
  access_key= "${var.access_key}"
  secret_key= "${var.secret_key}"
}

resource "tls_private_key" "rsa_4096" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name = "${var.key_name}"
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

resource "local_file" "private_key" {
  content = tls_private_key.rsa_4096.private_key_pem
  filename = "${var.key_name}"
}

resource "aws_instance" "web" {
  ami           = "ami-0fa377108253bf620"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key_pair.key_name  # Use the key pair name defined in the aws_key_pair resource block

  tags = {
    Name = "${var.ec2_name}"
  }
}

resource "null_resource" "chmod_private_key" {
  triggers = {
    private_key_filename = local_file.private_key.filename
  }

  provisioner "local-exec" {
    command = "chmod 400 ${local_file.private_key.filename}"
  }
}