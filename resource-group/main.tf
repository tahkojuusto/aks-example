resource "azurerm_resource_group" "resource_group" {
  name        = "${var.app_name}-resource-group"
  location    = "${var.location}"
}