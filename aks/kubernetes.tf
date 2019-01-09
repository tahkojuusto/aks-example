provider "kubernetes" {
  host                    = "${azurerm_kubernetes_cluster.aks.kube_config.0.host}"
  client_certificate      = "${base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)}"
  client_key              = "${base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_key)}"
  cluster_ca_certificate  = "${base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)}"
}

resource "kubernetes_secret" "docker_secret" {
  metadata {
    name = "docker-secrets"
  }

  data {
    docker_username = "${var.docker_username}"
    docker_password = "${var.docker_password}"
    docker_email    = "${var.docker_email}"
  }
}

resource "kubernetes_config_map" "environment_variables" {
  metadata {
    name = "env-variables"
  }

  data {
    app_name = "${var.app_name}"
  }
}
