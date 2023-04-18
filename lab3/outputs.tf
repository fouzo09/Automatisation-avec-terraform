output "get_instance_id" {
    description = "Recuperer le ID l'instance "
    value = aws_instance.web.id
}


output "get_instance_ip" {
    description = "Adresse IP de l'instance"
    value = aws_eip.myip.address
}