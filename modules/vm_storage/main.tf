resource "random_id" "random_suffix" {
  byte_length = 3
}

resource "azurerm_managed_disk" "mod_disk" {
  name                 = "${format("%smanagdisk%s", var.name, random_id.random_suffix.hex)}"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group_name}"
  storage_account_type = "${var.managed_disk_type}"
  create_option        = "Empty"
  disk_size_gb         = "${var.managed_disk_size}"

  tags {
    environment = "${var.environment}"
  }
}
