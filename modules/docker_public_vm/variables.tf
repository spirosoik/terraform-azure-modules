variable "resource_group_name" {
  description = "The name of the resource group under which the resources will be created"
}

variable "name" {}

variable "location" {
  description = "The name of the Azure region (e.g., West US)"
}

variable "environment" {
  description = "The environment"
}

variable "vm_count" {
  description = "The number of vms to instantiate"
  default     = 1
}

variable "vm_data_managed_disk_id" {
  description = "The ID of the the related managed storage data disk"
}

variable "vm_data_managed_disk_name" {
  description = "The name of the the related managed storage data disk"
}

variable "vm_data_managed_disk_size" {
  description = "The account and container where the OS disk will be instantiated"
}

variable "vm_os_managed_disk_type" {
  description = "The type of managed disk"
  default     = "Standard_LRS"
}

variable "vm_size" {
  description = "The size of the vm"
  default     = "Standard_DS1_v2"
}

variable "ubuntu_sku" {
  description = "The Ubuntu SKU"
  default     = "16.04.0-LTS"
}

variable "enable_ip_forwarding" {
  description = "Whether this VM will be forwarding ip packets"
  default     = false
}

variable "subnet_id" {
  description = "The subnet id where the NIC will be instantiated"
}

variable "private_ip_addresses" {
  description = "List of static RFC1918 addresses, one per VM. Ensure that at least vm_count are specified, or none"
  default     = []
}

variable "ssh_public_keyfile" {
  description = "Local Location of the ssh public key that will be used to login to the VM"
}

variable "username" {
  type        = "string"
  description = "Virtual Machine username"
}

variable "ansible_playbook" {
  type        = "string"
  description = " The playbook file which will be used for provision"
}

variable "ansible_env" {
  type        = "string"
  description = " The ansible env which should be used to run"
}
