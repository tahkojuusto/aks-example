resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.app_name}-aks"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  dns_prefix          = "${var.app_name}-dns-prefix"

  agent_pool_profile {
    name            = "default"
    count           = "${var.aks_node_count}"
    vm_size         = "${var.aks_vm_size}"
    os_type         = "Linux"
    os_disk_size_gb = "${var.aks_disk_size_gb}"
    vnet_subnet_id  = "${var.private_subnet_id}"
  }

  service_principal {
    client_id     = "${var.sp_client_id}"
    client_secret = "${var.sp_client_secret}"
  }

  linux_profile {
    admin_username = "ubuntu"
    ssh_key {
      key_data = "${var.ssh_key}"
    }
  }

  network_profile {
    network_plugin  = "azure"
  }

  addon_profile {
    http_application_routing {
      enabled = "true"
    }
  }
}