# ---------------------------------------------------------------------------------------------------------------------
# PIN TERRAFORM VERSION TO >= 0.12
# The examples have been upgraded to 0.12 syntax
# ---------------------------------------------------------------------------------------------------------------------

# terraform {
#   # This module is now only being tested with Terraform 0.13.x. However, to make upgrading easier, we are setting
#   # 0.12.26 as the minimum version, as that version added support for required_providers with source URLs, making it
#   # forwards compatible with 0.13.x code.
#   required_version = ">= 0.12.26"
# }

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.39"
    }
  }
}


provider "azurerm" {
  features {}
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
}

# ---------------------------------------------------------------------------------------------------------------------
# BASIC TERRAFORM EXAMPLE
# See test/terraform_aws_example.go for how to write automated tests for this code.
# ---------------------------------------------------------------------------------------------------------------------

resource "local_file" "example" {
  content  = "${var.example} + ${var.example2}"
  filename = "example.txt"
}

resource "local_file" "example2" {
  content  = var.example2
  filename = "example2.txt"
}

# resource "azurerm_resource_group" "rg" {
#   name     = "rg-test"
#   location = "westeurope"
# }

data "azurerm_resource_group" "rg" {
  name     = "rg-tf-test"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  resource_group_name = "rg-tf-test" #azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.rg.location #"westeurope" #azurerm_resource_group.rg.location
}
