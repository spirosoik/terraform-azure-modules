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

variable "managed_disk_type" {
  description = "Defines the type of storage account to be created, e.g., Standard_LRS, Standard_ZRS, Standard_GRS"
  default     = "Standard_LRS"
}

variable "managed_disk_size" {
  description = "The size of the managed disk"
}
