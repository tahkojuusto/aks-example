provider "azurerm" {
  version = "=1.20.0"
}

module "resource_group" {
  source                                  = "../resource-group"
  app_name                                = "${var.app_name}"
  location                                = "${var.location}"
}

module "service_principal" {
  source                                  = "../service-principal"
  app_name                                = "${var.app_name}"
  service_principal_name                  = "${var.service_principal_name}"
  service_principal_password              = "${var.service_principal_password}"  
  service_principal_password_expiry_date  = "${var.service_principal_password_expiry_date}"
}

module "network" {
  source                                  = "../network"
  app_name                                = "${var.app_name}"
  resource_group_name                     = "${module.resource_group.name}"
  location                                = "${var.location}"
  network_address_space                   = "${var.network_address_space}"
  subnet_address_prefix                   = "${var.subnet_address_prefix}"
}
module "acr" {
  source                                  = "../acr"
  resource_group_name                     = "${module.resource_group.name}"
  location                                = "${var.location}"
  registry_name                           = "${var.registry_name}"
  registry_sku                            = "${var.registry_sku}"
}

module "aks" {
  source                                  = "../aks"
  app_name                                = "${var.app_name}"
  resource_group_name                     = "${module.resource_group.name}"
  location                                = "${var.location}"
  private_subnet_id                       = "${module.network.subnet_id}"
  sp_client_id                            = "${module.service_principal.application_id}"
  sp_client_secret                        = "${var.service_principal_password}"
  ssh_key                                 = "${var.ssh_key}"
  docker_username                         = "${var.docker_username}"
  docker_email                            = "${var.docker_email}"
  docker_password                         = "${module.acr.container_registry_password}"
  aks_node_count                          = "${var.aks_node_count}"
  aks_vm_size                             = "${var.aks_vm_size}"
  aks_disk_size_gb                        = "${var.aks_disk_size_gb}"
}
