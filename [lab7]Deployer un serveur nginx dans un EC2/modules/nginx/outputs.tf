output "WEBSERVER_IP" {
    description = "IP DE LA MACHINE EC2"
    value = aws_instance.WEBSERVER.public_ip
}