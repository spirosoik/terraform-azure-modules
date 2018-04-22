output "public_vm_ids" {
  value = ["${azurerm_virtual_machine.public_docker_vm.*.id}"]
}

output "public_vm_ips" {
  value = ["${azurerm_public_ip.public_ip.*.ip_address}"]
}
