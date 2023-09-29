output "example" {
  value = var.example
}

output "example2" {
  value = var.example2
}

output "example_list" {
  value = var.example_list
}

output "example_map" {
  value = var.example_map
}

output "example_any" {
  value = var.example_any
}

# output "rg_id" {
#   value = azurerm_resource_group.rg.id
# }

# output "rg_name" {
#   value = azurerm_resource_group.rg.name
# }

output "example_rg_id" {
  value = data.azurerm_resource_group.rg.id
}

output "example_rg_name" {
  value = data.azurerm_resource_group.rg.name
}

output "vnet_location" {
  value = azurerm_virtual_network.vnet.location
}
