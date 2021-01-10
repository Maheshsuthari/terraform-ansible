variable "os_ami" {
  default = "linux"
}
variable "AMIS" {
  type = map
  default = {
        windows = "ami-0229f7666f517b31e"
        linux = "ami-0dba2cb6798deb6d8"
  }
}
variable "instance_type" {
  default = "t2.micro"
}
variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "ssh_user" {
     type = map
     default = { 
           windows = "adminsuser"
           linux  = "ubuntu"
    }
}
