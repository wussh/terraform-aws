# resource "aws_security_group" "web_sg" {
#   name        = "web_security_group"
#   description = "Security group for web servers"

#   // Add appropriate VPC ID if you are working in a VPC
#   // vpc_id = "vpc-12345678"
# }

# resource "aws_security_group_rule" "web_sg_inbound_rule" {
#   type              = "ingress"
#   from_port         = 9090
#   to_port           = 9090
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.web_sg.id
# }