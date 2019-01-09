variable "resource_group_name" {}
variable "location" {}
variable "private_subnet_id" {}
variable "sp_client_id" {}
variable "sp_client_secret" {}
variable "ssh_key" {}
variable "docker_username" {}
variable "docker_password" {}
variable "docker_email" {}
variable "app_name" {}
variable "aks_node_count" {
    default = 1
}
variable "aks_vm_size" {
    default = "Standard_A1_v2"
}
variable "aks_disk_size_gb" {
    default = 30
}