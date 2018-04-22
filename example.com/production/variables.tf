variable "base_name" {
  description = "The environment/leve"
}

variable "location" {
  description = "The name of the Azure region (e.g., West US)"
  default     = "West US"
}

variable "ssh_public_keyfile" {
  description = "The file location (local) of the ssh rsa public key that is used to login to the vm"
}
