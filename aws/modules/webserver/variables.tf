
variable "cidr_block" {
    type        = string
    description  = "vpc_cidr.block"
}

variable "webserver_name" {
    type        = string
    description = "Name of the webserver"
}
variable "instance_type" {
    type        = string
    description  = "instance.type"
}

variable "ami" {
    type      = string
    description = "ami_id"
}
variable "os_ami" {
  default = "linux"
}

variable "ssh_user" {
     description  = "ssh user"
}

