variable "aws_region" {
  default = "us-east-1"
}

variable "access_key" {
  default = "xxx"
}

variable "secret_key" {
  default = "xxx"
}

variable "vpc_name" {
  default = "Myvpc"
}

variable "ami_name" {
  default = "ami-xxx"
}

variable "public_subnet_name" {
  default = "public subnet"
}

variable "sg1_name" {
  default = "SG1"
}

variable "instance1_name" {
  default = "Instance1"
}


variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}


variable "public_subnet_cidr_block" {
  default = "10.0.0.0/24"
}

variable "sns_topic_name" {
  default = "demotopic"
}

variable "sns_topic_email" {
  default = "xxx@gmail.com"
}