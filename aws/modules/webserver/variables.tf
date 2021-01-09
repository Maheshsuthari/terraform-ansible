
variable "cidr_block" {
    type        = string
    description  = "subnet.cidr.block"
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
