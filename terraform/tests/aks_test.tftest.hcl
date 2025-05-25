variables {
  resource_group_name = "heroes-aks-rg-test"
  location            = "spaincentral"
  vnet_name           = "heroes-aks-vnet-test"
  address_space       = ["10.0.0.0/16"]
  subnet_name         = "heroes-aks-subnet-test"
  subnet_address_prefixes = ["10.0.1.0/24"]
  cluster_name        = "heroes-aks-cluster-test"
  dns_prefix          = "heroes-aks-test"
  node_size           = "Standard_B2s"
  node_count          = 2
}

# Test resource group creation
run "resource_group_creation" {
  command = plan

  assert {
    condition     = azurerm_resource_group.rg.name == var.resource_group_name
    error_message = "Resource group name does not match expected value"
  }

  assert {
    condition     = azurerm_resource_group.rg.location == var.location
    error_message = "Resource group location does not match expected value"
  }
}

# Test virtual network creation
run "vnet_creation" {
  command = plan

  assert {
    condition     = azurerm_virtual_network.vnet.name == var.vnet_name
    error_message = "Virtual network name does not match expected value"
  }

  assert {
    condition     = azurerm_virtual_network.vnet.address_space[0] == var.address_space[0]
    error_message = "Virtual network address space does not match expected value"
  }
}

# Test AKS cluster creation
run "aks_cluster_creation" {
  command = plan

  assert {
    condition     = azurerm_kubernetes_cluster.aks.name == var.cluster_name
    error_message = "AKS cluster name does not match expected value"
  }

  assert {
    condition     = azurerm_kubernetes_cluster.aks.dns_prefix == var.dns_prefix
    error_message = "AKS cluster DNS prefix does not match expected value"
  }

  assert {
    condition     = azurerm_kubernetes_cluster.aks.default_node_pool[0].vm_size == var.node_size
    error_message = "AKS node size does not match expected value"
  }

  assert {
    condition     = azurerm_kubernetes_cluster.aks.default_node_pool[0].node_count == var.node_count
    error_message = "AKS node count does not match expected value"
  }
}