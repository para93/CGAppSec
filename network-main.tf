# Create a resource group for victim network
resource "azurerm_resource_group" "victim-network-rg" {
  name     = "${var.victim_company}-rg"
  location = var.location
  tags = {
    application = var.victim_company
    environment = var.environment
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
