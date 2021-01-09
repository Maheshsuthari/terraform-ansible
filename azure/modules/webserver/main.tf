provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=2.5.0" 
 # subscription_id  = {}
 # client_id    = {}
 # client_secret = {}
 # tenant_id   = {}
  features {}
}

resource "azurerm_resource_group" "webserver" {
    name     = "webeGroup"
    location = "eastus"

    tags = {
        environment = "Terraform-test"
    }
}

resource "azurerm_virtual_network" "webserver" {
  location = "eastus"
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
  location = "eastus"
}
resource "azurerm_network_interface" "webnic" {
  name = "myvm1-nic"
  resource_group_name = azurerm_resource_group.webserver.name
  location = "eastus"
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
  admin_username        = "adminuser"
  admin_password        = "Password123!"
  location             = "eastus"
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
