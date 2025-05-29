# Terraform version constraints

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0, < 4.31.1"
      configuration_aliases = [azurerm.this]
    }
  }
}