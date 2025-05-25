# Main Terraform configuration file
# This file defines the main infrastructure components for deploying an AKS cluster

# Resource Group
module "resource_group" {
  source = "./modules/resource_group"
  providers = {
    azurerm = azurerm.this
    azurerm.this = azurerm.this
  }

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

# Network
module "network" {
  source = "./modules/network"
  providers = {
    azurerm = azurerm.this
    azurerm.this = azurerm.this
  }

  vnet_name           = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  subnet_name         = var.subnet_name
  subnet_address_prefixes = var.subnet_address_prefixes
  tags                = var.tags

  depends_on = [module.resource_group]
}

# AKS Cluster
module "aks" {
  source = "./modules/aks"
  providers = {
    azurerm = azurerm.this
    azurerm.this = azurerm.this
  }

  cluster_name        = var.cluster_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  node_size           = var.node_size
  node_count          = var.node_count
  enable_auto_scaling = var.enable_auto_scaling
  min_node_count      = var.min_node_count
  max_node_count      = var.max_node_count
  subnet_id           = module.network.subnet_id
  os_disk_size_gb     = var.os_disk_size_gb
  tags                = var.tags

  depends_on = [module.network]
}