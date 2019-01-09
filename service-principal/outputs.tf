output "application_id" {
  value = "${azurerm_azuread_application.ad_application.application_id}"
}

output "service_principal_id" {
  value = "${azurerm_azuread_service_principal.service_principal.id}"
}