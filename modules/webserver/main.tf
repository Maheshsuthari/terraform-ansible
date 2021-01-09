locals {
  ssh_user         = "ubuntu"
  key_name         = "suthari"
  private_key_path = "../suthari.pem"
}
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}
resource "aws_route_table" "r" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "main"
  }
}
resource "aws_subnet" "webserver" {
   vpc_id     = aws_vpc.main.id
   cidr_block = var.cidr_block
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.webserver.id
  route_table_id = aws_route_table.r.id
}

resource "aws_security_group" "webserver" {
  name   = "nginx_access"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "webserver" {
  ami                         = var.ami  
  subnet_id                   = aws_subnet.webserver.id 
  instance_type               = var.instance_type
  associate_public_ip_address = true
  security_groups             = [aws_security_group.webserver.id]
  key_name                    = local.key_name

  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'", "sudo apt update -y", "sudo apt install python3 -y", "sudo apt install ansible -y", "echo 'done'"]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = aws_instance.webserver.public_ip
    }
  }
  provisioner "local-exec" {
    command = "ansible-playbook  -i ${aws_instance.webserver.public_ip}, --private-key ${local.private_key_path} nginx.yaml"
  }
}

output "nginx_ip" {
  value = aws_instance.webserver.public_ip
}

