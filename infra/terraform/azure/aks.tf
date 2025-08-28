resource "azurerm_kubernetes_cluster" "main" {
  name = "${var.name_prefix}-aks"
  location = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  dns_prefix = var.name_prefix
  default_node_pool {
    name = var.name_prefix
    vm_size = var.aks_machine_type
    node_count = var.aks_node_count
    vnet_subnet_id = azurerm_subnet.main.id
scale_down_mode = "Delete"
node_public_ip_enabled = false
tags = "null"
  }
  identity {
    type = "SystemAssigned"
  }
open_service_mesh_enabled = true
oidc_issuer_enabled = true
key_vault_secrets_provider {
secret_rotation_enabled = true
}
kubernetes_version = "1.2.18"
}