provider "aws" {
  region = "us-east-1"
  access_key = "AKIxxyyy--ACKVKYYHHG6"
  secret_key = "j0/4rmRTwxEw"
}
module "webserver" {
  source  =   "../modules/webserver"
  cidr_block = "10.0.0.0/16"
  webserver_name = "mahesh"
  ami           = "${lookup(var.AMIS, var.os_ami)}"
  instance_type  = var.instance_type
 
}


