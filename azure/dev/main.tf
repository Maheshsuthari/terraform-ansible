provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=2.5.0" 
 # subscription_id  = {}
 # client_id    = {}
 # client_secret = {}
 # tenant_id   = {}
  features {}
}

module "webserver" {
  source  = "../modules/webserver"
  admin_username = var.admin_username
  admin_password = var.admin_password
  location  = var.location
}
