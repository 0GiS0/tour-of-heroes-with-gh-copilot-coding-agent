# Outputs for AKS deployment

output "resource_group_name" {
  description = "The name of the resource group"
  value       = module.resource_group.resource_group_name
}

output "aks_cluster_name" {
  description = "The name of the AKS cluster"
  value       = module.aks.aks_name
}

output "aks_cluster_id" {
  description = "The ID of the AKS cluster"
  value       = module.aks.aks_id
}

output "kube_config" {
  description = "The kubeconfig to connect to the AKS cluster"
  value       = module.aks.kube_config
  sensitive   = true
}

output "node_resource_group" {
  description = "The auto-generated resource group name for the AKS cluster resources"
  value       = module.aks.node_resource_group
}

output "vnet_name" {
  description = "The name of the virtual network"
  value       = module.network.vnet_name
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = module.network.subnet_id
}

output "storage_account_name" {
  description = "The name of the Azure Storage Account"
  value       = module.storage_account.name
}

output "storage_account_id" {
  description = "The ID of the Azure Storage Account"
  value       = module.storage_account.id
}