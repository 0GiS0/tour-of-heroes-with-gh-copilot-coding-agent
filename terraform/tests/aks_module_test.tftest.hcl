variables {
  resource_group_name = "heroes-aks-module-rg-test"
  location            = "spaincentral"
  cluster_name        = "test-aks-cluster"
  dns_prefix          = "test-aks"
  node_size           = "Standard_B2s"
  node_count          = 2
  enable_auto_scaling = true
  min_node_count      = 1
  max_node_count      = 3
  subnet_id           = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/test-rg/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/test-subnet"
  tags = {
    Environment = "Test"
    ManagedBy   = "Terraform"
  }
}

# Test AKS module
run "aks_module" {
  command = plan

  module {
    source = "../modules/aks"
  }

  variables {
    resource_group_name = var.resource_group_name
    location            = var.location
    cluster_name        = var.cluster_name
    dns_prefix          = var.dns_prefix
    kubernetes_version  = null
    node_size           = var.node_size
    node_count          = var.node_count
    enable_auto_scaling = var.enable_auto_scaling
    min_node_count      = var.min_node_count
    max_node_count      = var.max_node_count
    subnet_id           = var.subnet_id
    tags                = var.tags
  }

  assert {
    condition     = azurerm_kubernetes_cluster.aks.name == var.cluster_name
    error_message = "AKS cluster name does not match expected value"
  }

  assert {
    condition     = azurerm_kubernetes_cluster.aks.dns_prefix == var.dns_prefix
    error_message = "AKS DNS prefix does not match expected value"
  }

  assert {
    condition     = azurerm_kubernetes_cluster.aks.default_node_pool[0].vm_size == var.node_size
    error_message = "AKS node size does not match expected value"
  }

  assert {
    condition     = azurerm_kubernetes_cluster.aks.default_node_pool[0].enable_auto_scaling == var.enable_auto_scaling
    error_message = "AKS auto scaling setting does not match expected value"
  }

  assert {
    condition     = azurerm_kubernetes_cluster.aks.default_node_pool[0].min_count == var.min_node_count
    error_message = "AKS min node count does not match expected value"
  }

  assert {
    condition     = azurerm_kubernetes_cluster.aks.default_node_pool[0].max_count == var.max_node_count
    error_message = "AKS max node count does not match expected value"
  }
}