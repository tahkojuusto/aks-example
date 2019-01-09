resource "azurerm_azuread_application" "ad_application" {
  name = "${var.service_principal_name}"
}

resource "azurerm_azuread_service_principal" "service_principal" {
  application_id = "${azurerm_azuread_application.ad_application.application_id}"
}

resource "azurerm_azuread_service_principal_password" "service_principal_password" {
  service_principal_id = "${azurerm_azuread_service_principal.service_principal.id}"
  value                = "${var.service_principal_password}"
  end_date             = "${var.service_principal_password_expiry_date}"
}

data "azurerm_subscription" "subscription" {}

resource "azurerm_role_assignment" "service_principal_role" {
    role_definition_name    = "Contributor"
    scope                   = "${data.azurerm_subscription.subscription.id}"
    principal_id            = "${azurerm_azuread_service_principal.service_principal.id}"
}