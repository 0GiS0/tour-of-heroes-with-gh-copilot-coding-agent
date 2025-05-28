# Variables for AKS deployment

# Azure Provider
variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
}

# General
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "heroes-aks-rg"
}

variable "location" {
  description = "The Azure region where resources should be created"
  type        = string
  default     = "spaincentral"
}

variable "tags" {
  description = "A map of tags to add to resources"
  type        = map(string)
  default = {
    Environment = "Development"
    Application = "Heroes-API"
    ManagedBy   = "Terraform"
  }
}

# Network
variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
  default     = "heroes-aks-vnet"
}

variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default     = "heroes-aks-subnet"
}

variable "subnet_address_prefixes" {
  description = "The address prefixes for the subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

# AKS
variable "cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
  default     = "heroes-aks-cluster"
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
  default     = "heroes-aks"
}

variable "kubernetes_version" {
  description = "The Kubernetes version to use"
  type        = string
  default     = null # Use the latest supported version by default
}

variable "node_size" {
  description = "The size of the VM instances"
  type        = string
  default     = "Standard_B2s" # Small, cost-effective VM size
}

variable "node_count" {
  description = "The number of nodes in the AKS cluster"
  type        = number
  default     = 2
}

variable "enable_auto_scaling" {
  description = "Whether to enable auto-scaling"
  type        = bool
  default     = true
}

variable "min_node_count" {
  description = "The minimum number of nodes (when auto-scaling is enabled)"
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "The maximum number of nodes (when auto-scaling is enabled)"
  type        = number
  default     = 3
}

variable "os_disk_size_gb" {
  description = "The size of the OS disk in GB"
  type        = number
  default     = 30
}

variable "storage_account_name" {
  description = "The name of the Azure Storage Account"
  type        = string
  default     = "heroesstorage${random_integer.suffix.result}"
}
