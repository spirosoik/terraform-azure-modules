output "managed_disk_id" {
  value = "${azurerm_managed_disk.mod_disk.id}"
}

output "managed_disk_name" {
  value = "${azurerm_managed_disk.mod_disk.name}"
}
