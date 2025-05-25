variable "cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "location" {
  description = "The Azure region where resources should be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
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

variable "subnet_id" {
  description = "The ID of the subnet where the AKS nodes should be provisioned"
  type        = string
}

variable "os_disk_size_gb" {
  description = "The size of the OS disk in GB"
  type        = number
  default     = 30
}

variable "tags" {
  description = "A map of tags to add to resources"
  type        = map(string)
  default     = {}
}

variable "service_cidr" {
  description = "The CIDR to use for service IPs"
  type        = string
  default     = "172.16.0.0/16"
}

variable "dns_service_ip" {
  description = "The IP address within the service CIDR that will be used by cluster service discovery (kube-dns)"
  type        = string
  default     = "172.16.0.10"
}