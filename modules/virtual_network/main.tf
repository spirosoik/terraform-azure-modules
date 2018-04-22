# Create a virtual network in a resource group
resource "azurerm_virtual_network" "mod" {
  name                = "${format("%s-vnet", var.name)}"
  address_space       = ["${var.cidr}"]
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  tags {
    environment = "${var.environment}"
  }
}

# Create a public subnet for the virtual network
resource "azurerm_subnet" "public" {
  name                 = "${format("%s-subnet-public", var.name)}"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.mod.name}"
  address_prefix       = "${var.public_subnet}"
}

# Create a private subnet for the virtual network
resource "azurerm_subnet" "private" {
  count                = "${var.private_subnet == "" ? 0: 1}"
  name                 = "${format("%s-subnet-private", var.name)}"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.mod.name}"
  address_prefix       = "${var.private_subnet}"

  tags {
    environment = "${var.environment}"
  }
}
