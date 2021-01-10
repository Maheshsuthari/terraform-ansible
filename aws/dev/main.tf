provider "aws" {
  region = "us-east-1"
  access_key = {}
  secret_key = {}
}
module "webserver" {
  source  =   "../modules/webserver"
  cidr_block = var.cidr_block
  webserver_name = "mahesh"
  ami           = "${lookup(var.AMIS, var.os_ami)}"
  instance_type  = var.instance_type
  ssh_user      = var.ssh_user
}


