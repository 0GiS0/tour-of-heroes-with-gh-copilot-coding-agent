terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      configuration_aliases = [azurerm.this]


    }
  }
}

# AKS Module
# This module creates an Azure Kubernetes Service cluster

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name            = "default"
    vm_size         = var.node_size
    node_count      = var.node_count
    vnet_subnet_id  = var.subnet_id
    os_disk_size_gb = var.os_disk_size_gb
    tags            = var.tags
    # Solo incluir min_count y max_count si enable_auto_scaling es true
    # No se puede usar dynamic para atributos simples, así que hay que documentar y controlar desde variables
    # El usuario debe pasar min_count y max_count solo si enable_auto_scaling es true
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    network_policy    = "azure"
    service_cidr      = var.service_cidr
    dns_service_ip    = var.dns_service_ip
  }

  tags = var.tags
}
