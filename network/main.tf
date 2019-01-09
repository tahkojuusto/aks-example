resource "azurerm_virtual_network" "virtual_network" {
  name                = "${var.app_name}-virtual-network"
  address_space       = ["${var.network_address_space}"]
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
}

resource "azurerm_subnet" "private_subnet" {
  name                      = "${var.app_name}-private-subnet"
  resource_group_name       = "${var.resource_group_name}"
  address_prefix            = "${var.subnet_address_prefix}"
  virtual_network_name      = "${azurerm_virtual_network.virtual_network.name}"
  network_security_group_id = "${azurerm_network_security_group.private_subnet_security_group.id}"
}

resource "azurerm_network_security_group" "private_subnet_security_group" {
  name                = "${var.app_name}-private-subnet-security-group"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
}
