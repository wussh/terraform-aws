variable "access_key" {
  description = "AWS Access Key"
  type = string
}

variable "secret_key" {
  description = "AWS Secret Key"
  type = string
}

variable "ec2_name" {
  description = "EC2 Name"
  type = string
}

variable "key_name" {
  description = "AWS Key Name"
  type = string
}

variable "vpc_id" {
  description = "AWS VPC ID"
  type=string
}