# victim company name 
variable "victim_company" {
  type        = string
  description = "Victim Company used in Naming Convention"
}

# aws region
variable "location" {
  type        = string
  description = "AWS region where the resources will be created"
  default     = "us-east-2"
}

# victim vpc cidr block
variable "victim-network-vpc-cidr" {
  type        = string
  description = "VPC CIDR Block"
  default     = "10.20.0.0/16"
}

# victim vpc cidr AWS public subnet
variable "victim-network-subnet-cidr" {
  type        = string
  description = "Public Subnet"
  default     = "10.20.0.0/24"
}

# SC_EXT private ip
variable "internal-private-ip" {
  type        = string
  description = "Private Subnet"
  default     = "10.20.0.10"
}

variable "private-subnet-1-cidr" {
  default       = "10.0.2.0/24"
  description   = "Private Subnet 1 CIDR Block"
  type          = string
}


# environment
variable "environment" {
  type        = string
  description = "Staging or Production"
  default     = "staging"
}

# vulnvm-name
variable "vulnvm-name" {
  type        = string
  description = "Name of Vulnerable VM"
  default     = "JuiceShopWAAPDemo"
}

# username
variable "username" {
  type        = string
  description = "Username"
}

# password
variable "password" {
  type        = string
  description = "Password"
}

# token
variable "token" {
  type        = string
  description = "WAAP Token"
}
