
resource "azurerm_resource_group" "webserver" {
    name     = "webeGroup"
    location = var.location

    tags = {
        environment = "Terraform-test"
    }
}

resource "azurerm_virtual_network" "webserver" {
  location = var.location
  name = "webserver"
  address_space = ["10.0.0.0/16"]
  resource_group_name = azurerm_resource_group.webserver.name
}

resource "azurerm_subnet" "webserver" {
  name = "frontendSubnet"
  resource_group_name =  azurerm_resource_group.webserver.name
  virtual_network_name = azurerm_virtual_network.webserver.name
  address_prefix = "10.0.1.0/24"
}
resource "azurerm_public_ip" "webpublicip" {
  name = "pip1"
  resource_group_name = azurerm_resource_group.webserver.name
  allocation_method = "Dynamic"
  sku = "Basic"
  location = var.location
}
resource "azurerm_network_interface" "webnic" {
  name = "myvm1-nic"
  resource_group_name = azurerm_resource_group.webserver.name
  location = var.location 
  ip_configuration {
    name = "ipconfig1"
    subnet_id = azurerm_subnet.webserver.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.webpublicip.id
  }
}
resource "azurerm_windows_virtual_machine" "webserver" {
  name                  = "myvm1"
  resource_group_name   = azurerm_resource_group.webserver.name
  network_interface_ids = [azurerm_network_interface.webnic.id]
  size                  = "Standard_B1s"
  admin_username        =  var.admin_username
  admin_password        =  var.admin_password
  location             = var.location
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}
