variables {
  resource_group_name = "heroes-modules-rg-test"
  location            = "spaincentral"
  tags = {
    Environment = "Test"
    ManagedBy   = "Terraform"
  }
}

# Test resource group module
run "resource_group_module" {
  command = plan

  module {
    source = "../modules/resource_group"
  }

  variables {
    name     = var.resource_group_name
    location = var.location
    tags     = var.tags
  }

  assert {
    condition     = azurerm_resource_group.rg.name == var.resource_group_name
    error_message = "Resource group name does not match expected value"
  }

  assert {
    condition     = azurerm_resource_group.rg.location == var.location
    error_message = "Resource group location does not match expected value"
  }

  assert {
    condition     = azurerm_resource_group.rg.tags["Environment"] == var.tags["Environment"]
    error_message = "Resource group environment tag does not match expected value"
  }
}

# Test network module
run "network_module" {
  command = plan

  module {
    source = "../modules/network"
  }

  variables {
    resource_group_name     = var.resource_group_name
    location                = var.location
    vnet_name               = "test-vnet"
    address_space           = ["10.0.0.0/16"]
    subnet_name             = "test-subnet"
    subnet_address_prefixes = ["10.0.1.0/24"]
    tags                    = var.tags
  }

  assert {
    condition     = azurerm_virtual_network.vnet.name == "test-vnet"
    error_message = "Virtual network name does not match expected value"
  }

  assert {
    condition     = azurerm_virtual_network.vnet.address_space[0] == "10.0.0.0/16"
    error_message = "Virtual network address space does not match expected value"
  }

  assert {
    condition     = azurerm_subnet.subnet.name == "test-subnet"
    error_message = "Subnet name does not match expected value"
  }
}