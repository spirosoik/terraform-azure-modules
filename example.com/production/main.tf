terraform {
  backend "azurerm" {
    key = "example.com/production/terraform.tfstate"
  }
}

provider "azurerm" {}

resource "random_id" "random_suffix" {
  byte_length = 3
}

resource "azurerm_resource_group" "resource_group" {
  name     = "${format("rg-%s-%s", var.base_name, random_id.random_suffix.hex)}"
  location = "${var.location}"
}

module "vnet" {
  source = "../../modules/virtual_network"

  name                = "${var.base_name}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"

  environment   = "${var.base_name}"
  cidr          = "10.120.0.0/16"
  public_subnet = "10.120.20.0/24"
}

module "storage" {
  source = "../../modules/vm_storage"

  name                = "${var.base_name}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"

  environment       = "${var.base_name}"
  managed_disk_size = "4095"
}

module "ubuntu_public_vm" {
  source = "../../modules/docker_public_vm"

  name                = "${var.base_name}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"

  environment               = "${var.base_name}"
  username                  = "test"
  vm_data_managed_disk_name = "${module.storage.managed_disk_name}"
  vm_data_managed_disk_id   = "${module.storage.managed_disk_id}"
  vm_data_managed_disk_size = "4095"

  subnet_id          = "${module.vnet.public_subnet}"
  ssh_public_keyfile = "${var.ssh_public_keyfile}"

  vm_count = 1

  ansible_env      = "prod"
  ansible_playbook = "example-prod.yml"
}
