# Create AWS VPC
# terraform aws create vpc
resource "aws_vpc" "vpc" {
  cidr_block              = "${var.victim-network-vpc-cidr}"
  instance_tenancy        = "default"
  enable_dns_hostnames    = true

  tags      = {
    Name    = "AppSec VPC"
  }
}

# Create Internet Gateway and Attach it to VPC
# terraform aws create internet gateway
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id    = aws_vpc.vpc.id

  tags      = {
    Name    = "AppSec IGW"
  }
}

# Create AWS Public Subnet 1
# terraform aws create subnet
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "${var.victim-network-subnet-cidr}"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags      = {
    Name    = AppSec Public Subnet
  }
}

# Create Public Subnet 2
# terraform aws create subnet
resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "${var.internal-private-ip}"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true

  tags      = {
    Name    = "Public Subnet 2"
  }
}

# Create Route Table and Add Public Route
# terraform aws create route table
resource "aws_route_table" "public-route-table" {
  vpc_id       = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }

  tags       = {
    Name     = "Default Public Route Table"
  }
}

# Associate Public Subnet 1 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public-subnet-1-route-table-association" {
  subnet_id           = aws_subnet.public-subnet-1.id
  route_table_id      = aws_route_table.public-route-table.id
}

# Associate Public Subnet 2 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public-subnet-2-route-table-association" {
  subnet_id           = aws_subnet.public-subnet-2.id
  route_table_id      = aws_route_table.public-route-table.id
}

# Create Private Subnet 1
# terraform aws create subnet
resource "aws_subnet" "private-subnet-1" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = "${var.private-subnet-1-cidr}"
  availability_zone        = "us-east-2a"
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "Private Subnet 1 | App Tier"
  }
}

# Create Private Subnet 2
# terraform aws create subnet
resource "aws_subnet" "private-subnet-2" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = "${var.private-subnet-2-cidr}"
  availability_zone        = "us-east-2b"
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "Private Subnet 2 | App Tier"
  }
}

# Create Private Subnet 3
# terraform aws create subnet
resource "aws_subnet" "private-subnet-3" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = "${var.private-subnet-3-cidr}"
  availability_zone        = "
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "Private Subnet 3"
  }
}

# Create Private Subnet 4
# terraform aws create subnet
resource "aws_subnet" "private-subnet-4" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = "${var.private-subnet-4-cidr}"
  availability_zone        =
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "Private Subnet 4"
  }
}








# Create the victim network VPC
resource "azurerm_virtual_network" "victim-network-vpc" {
  name                = "${var.victim_company}-vpc"
  address_space       = [var.victim-network-vpc-cidr]
  resource_group_name = azurerm_resource_group.victim-network-rg.name
  location            = azurerm_resource_group.victim-network-rg.location
  tags = {
    application = var.victim_company
    environment = var.environment
  }
}

# Create a victim subnet for Network
resource "azurerm_subnet" "victim-network-subnet" {
  name                 = "${var.victim_company}-subnet"
  address_prefix       = var.victim-network-subnet-cidr
  virtual_network_name = azurerm_virtual_network.victim-network-vpc.name
  resource_group_name  = azurerm_resource_group.victim-network-rg.name
}
