# Provider configuration

# Configure the Azure provider
provider "azurerm" {
  alias           = "this"
  subscription_id = var.subscription_id
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}