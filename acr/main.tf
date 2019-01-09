resource "azurerm_container_registry" "container_registry" {
  name                = "${var.registry_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  sku                 = "${var.registry_sku}"
  admin_enabled       = "true"
}