# Create public IP
resource "azurerm_public_ip" "public_ip" {
  name                         = "${format("%s-docker-public-ip-%d", var.name, count.index)}"
  location                     = "${var.location}"
  resource_group_name          = "${var.resource_group_name}"
  count                        = "${var.vm_count}"
  public_ip_address_allocation = "static"

  tags {
    environment = "${var.environment}"
  }
}

# Create a network interface
resource "azurerm_network_interface" "public_nic" {
  name                 = "${format("%s-docker-vm-public-nic-%d", var.name, count.index)}"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group_name}"
  enable_ip_forwarding = "${var.enable_ip_forwarding}"

  ip_configuration {
    name                          = "${format("%s-docker-nic-public-ip", var.name)}"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${element(azurerm_public_ip.public_ip.*.id, count.index)}"
  }

  tags {
    environment = "${var.environment}"
  }
}

resource "azurerm_virtual_machine" "public_docker_vm" {
  name                  = "${format("%s-docker-vm-public-%d", var.name, count.index)}"
  location              = "${var.location}"
  resource_group_name   = "${var.resource_group_name}"
  network_interface_ids = ["${element(azurerm_network_interface.public_nic.*.id, count.index)}"]
  vm_size               = "${var.vm_size}"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "${var.ubuntu_sku}"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${format("%s-docker-public-vm-os-disk-%d", var.name, count.index)}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "${var.vm_os_managed_disk_type}"
  }

  storage_data_disk {
    name            = "${var.vm_data_managed_disk_name}"
    managed_disk_id = "${var.vm_data_managed_disk_id}"
    create_option   = "Attach"
    lun             = 0
    disk_size_gb    = "${var.vm_data_managed_disk_size}"
  }

  os_profile {
    computer_name  = "${format("%s-docker-public-vm-%d", var.name, count.index)}"
    admin_username = "${var.username}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys = [{
      path     = "/home/${var.username}/.ssh/authorized_keys"
      key_data = "${file("../keys/whatever.pub")}"
    }]
  }

  connection {
    type        = "ssh"
    user        = "${var.username}"
    private_key = "${file("../keys/whatever.pem")}"
    agent       = "false"
    host        = "${element(azurerm_public_ip.public_ip.*.ip_address, count.index)}"
  }

  provisioner "remote-exec" {
    inline = ["echo waiting"]
  }

  provisioner "local-exec" {
    command = "cd ../../ansible && echo \"[${var.environment}]\n${azurerm_public_ip.public_ip.ip_address} ansible_connection=ssh ansible_ssh_user=${var.username}\" > ${var.ansible_env}; ansible-playbook -i ${var.ansible_env} ${var.ansible_playbook}"
  }

  tags {
    environment = "${var.environment}"
  }
}
