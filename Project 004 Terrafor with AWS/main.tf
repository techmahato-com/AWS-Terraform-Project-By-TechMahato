# main.tf


# Step-01: Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true


  tags = {
    Name        = "my-vpc"
    Environment = var.environment
  }
}


# Step-03: Create Subnets
# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.public_subnet_cidr_block
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true


  tags = {
    Name        = "my-public-subnet"
    Environment = var.environment
  }
}


# Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_subnet_cidr_block
  availability_zone = var.availability_zone


  tags = {
    Name        = "my-private-subnet"
    Environment = var.environment
  }
}


# Step-04: Create Internet Gateway and Associate it to VPC
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id


  tags = {
    Name        = "my-igw"
    Environment = var.environment
  }
}


# Step-05: Create NAT Gateway
resource "aws_nat_gateway" "my_nat_gateway" {
  allocation_id = aws_eip.my_eip.id
  subnet_id     = aws_subnet.public_subnet.id


  tags = {
    Name        = "my-nat-gateway"
    Environment = var.environment
  }
}


resource "aws_eip" "my_eip" {
  vpc = true


  tags = {
    Name        = "my-eip"
    Environment = var.environment
  }
}


# Step-06: Create Public Route Table and Associate Subnets
# Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id


  tags = {
    Name        = "my-public-route-table"
    Environment = var.environment
  }
}


# Public Route
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}


# Associate Public Subnet
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}


# Step-07: Create Private Route Table and Associate Subnets
# Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id


  tags = {
    Name        = "my-private-route-table"
    Environment = var.environment
  }
}


# Private Route
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.my_nat_gateway.id
}


# Associate Private Subnet
resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}
