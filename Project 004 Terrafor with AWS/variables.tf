# variables.tf


variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}


variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}


variable "private_subnet_cidr_block" {
  description = "CIDR block for the private subnet"
  default     = "10.0.101.0/24"
}


variable "availability_zone" {
  description = "Availability zone for the subnets"
  default     = "us-east-1a"
}


variable "environment" {
  description = "Environment tag for resources"
  default     = "development"
}
