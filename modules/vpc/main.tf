
# VPC
resource "aws_vpc" "this_vpc" {
  cidr_block           = var.VPC_CIDR
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.COMMON_TAGS,
    {
      Name = var.VPC_NAME
    }
  )
}
# Internet Gateway
resource "aws_internet_gateway" "this_igw" {
  vpc_id = aws_vpc.this_vpc.id

  tags = merge(
    var.COMMON_TAGS,
    {
      Name = "${var.VPC_NAME}-igw"
    }
  )
}
# Public Subnet 1
resource "aws_subnet" "this_public_subnet_1" {
  vpc_id                  = aws_vpc.this_vpc.id
  cidr_block              = var.PUBLIC_SUBNET_1_CIDR
  availability_zone       = var.PUBLIC_SUBNET_1_AZ
  map_public_ip_on_launch = true
  tags = merge(
    var.COMMON_TAGS,
    {
      Name = "${var.VPC_NAME}-public-subnet-1"
    }
  )
}
# Public Subnet 2
resource "aws_subnet" "this_public_subnet_2" {
  vpc_id                  = aws_vpc.this_vpc.id
  cidr_block              = var.PUBLIC_SUBNET_2_CIDR
  availability_zone       = var.PUBLIC_SUBNET_2_AZ
  map_public_ip_on_launch = true
  tags = merge(
    var.COMMON_TAGS,
    {
      Name = "${var.VPC_NAME}-public-subnet-2"
    }
  )
}
# Private Application Subnet
resource "aws_subnet" "this_private_app_subnet" {
  vpc_id            = aws_vpc.this_vpc.id
  cidr_block        = var.PRIVATE_APP_SUBNET_CIDR
  availability_zone = var.PRIVATE_APP_SUBNET_AZ

  tags = merge(
    var.COMMON_TAGS,
    {
      Name = "${var.VPC_NAME}-private-app-subnet"
    }
  )
}
# Private Database Subnet
resource "aws_subnet" "this_private_db_subnet" {
  vpc_id            = aws_vpc.this_vpc.id
  cidr_block        = var.PRIVATE_DB_SUBNET_CIDR
  availability_zone = var.PRIVATE_DB_SUBNET_AZ

  tags = merge(
    var.COMMON_TAGS,
    {
      Name = "${var.VPC_NAME}-private-db-subnet"
    }
  )
}
# Elastic IP for NAT Gateway
resource "aws_eip" "this_nat_eip" {
  domain = "vpc"

  tags = merge(
    var.COMMON_TAGS,
    {
      Name = "${var.VPC_NAME}-nat-eip"
    }
  )
}
# NAT Gateway
resource "aws_nat_gateway" "this_nat_gateway" {
  allocation_id = aws_eip.this_nat_eip.id
  subnet_id     = aws_subnet.this_public_subnet_1.id

  depends_on = [
    aws_internet_gateway.this_igw
  ]

  tags = merge(
    var.COMMON_TAGS,
    {
      Name = "${var.VPC_NAME}-nat"
    }
  )
}
# Public Route Table
resource "aws_route_table" "this_public_route_table" {
  vpc_id = aws_vpc.this_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this_igw.id
  }

  tags = merge(
    var.COMMON_TAGS,
    {
      Name = "${var.VPC_NAME}-public-rt"
    }
  )
}
# Public Subnet 1 Route Association
resource "aws_route_table_association" "this_public_subnet_1" {
  subnet_id      = aws_subnet.this_public_subnet_1.id
  route_table_id = aws_route_table.this_public_route_table.id
}
# Public Subnet 2 Route Association
resource "aws_route_table_association" "this_public_subnet_2" {
  subnet_id      = aws_subnet.this_public_subnet_2.id
  route_table_id = aws_route_table.this_public_route_table.id
}
# Private Route Table
resource "aws_route_table" "this_private_route_table" {
  vpc_id = aws_vpc.this_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this_nat_gateway.id
  }
  tags = merge(
    var.COMMON_TAGS,
    {
      Name = "${var.VPC_NAME}-private-rt"
    }
  )
}
# Private Application Route Table Association
resource "aws_route_table_association" "this_private_app_route_association" {
  subnet_id      = aws_subnet.this_private_app_subnet.id
  route_table_id = aws_route_table.this_private_route_table.id
}
# Private Database Route Table Association
resource "aws_route_table_association" "this_private_db_route_association" {
  subnet_id      = aws_subnet.this_private_db_subnet.id
  route_table_id = aws_route_table.this_private_route_table.id
}