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
  default     = "10.0.0.0/16"
  
# victim vpc ipv6 cidr block
variable "victim-network-vpc-cidr-ipv6" {
  type        = string
  description = "VPC CIDR Block"
  default     = "::/0"

# victim vpc cidr AWS public subnet
variable "public-subnet-1-cidr" {
  type        = string
  description = "Public Subnet 1 CIDR Block"
  default     = "10.0.0.0/24"
}

variable "public-subnet-2-cidr" {
  default       = "10.0.1.0/24"
  description   = "Public Subnet 2 CIDR Block"
  type          = string
}
variable "private-subnet-1-cidr" {
  default       = "10.0.2.0/24"
  description   = "Private Subnet 1 CIDR Block"
  type          = string
}

variable "private-subnet-2-cidr" {
  default       = "10.0.3.0/24"
  description   = "Private Subnet 2 CIDR Block"
  type          = string
}

variable "private-subnet-3-cidr" {
  default       = "10.0.4.0/24"
  description   = "Private Subnet 3 CIDR Block"
  type          = string
}

variable "private-subnet-4-cidr" {
  default       = "10.0.5.0/24"
  description   = "Private Subnet 4 CIDR Block"
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
  
]  
