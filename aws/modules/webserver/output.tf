output "instance" {
  value   = aws_instance.webserver
  description = "webserevr content"
}

output "security_group" {
  value  = aws_security_group.webserver.id
  description = "webserver securitygroup id"
}
