resource "azurerm_storage_account" "main" {
  name = "${var.name_prefix}storage"
  resource_group_name = data.azurerm_resource_group.main.name
  location = data.azurerm_resource_group.main.location
  account_kind = "StorageV2"
  account_tier = "Standard"
  account_replication_type = var.storage_account_replication_type
  allow_blob_public_access = true
tags = "null"
infrastructure_encryption_enabled = true
allow_nested_items_to_be_public = false
public_network_access_enabled = false
https_traffic_only_enabled = true
blob_properties {
versioning_enabled = true
delete_retention_policy {
permanent_delete_enabled = false
}
}
queue_properties {
logging {
write = true
read = true
delete = true
}
minute_metrics {
retention_policy_days = "30"
}
}
}

resource "azurerm_storage_container" "staging" {
  name = "staging"
  storage_account_name = azurerm_storage_account.main.name
container_access_type = "private"
}

resource "azurerm_storage_container" "kafka" {
  name = "kafkastorage"
  storage_account_name = azurerm_storage_account.main.name
container_access_type = "private"
}
resource "azurerm_storage_encryption_scope" "my_azurerm_storage_encryption_scope_azurerm_storage_account_main" {
storage_account_id = azurerm_storage_account.main.id
source = "Microsoft.Storage"
}