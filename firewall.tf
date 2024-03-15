resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_sg"
  description = "Security group for the EC2 instance"
  vpc_id = var.vpc_id

  // Define inbound rules
  ingress {
    from_port   = 22  // Example SSH port
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  // Add additional inbound rules as needed
  ingress {
     from_port   = 8080
     to_port     = 8080
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
     ipv6_cidr_blocks = ["::/0"]
  }

  // Define outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  // Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags ={
    Name = "jenkins_sg"
  }
}
