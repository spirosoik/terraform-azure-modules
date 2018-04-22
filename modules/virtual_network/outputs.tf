output "private_subnet" {
  value = "${azurerm_subnet.private.*.id}"
}

output "public_subnet" {
  value = "${azurerm_subnet.public.id}"
}

output "vnet_id" {
  value = "${azurerm_virtual_network.mod.id}"
}
