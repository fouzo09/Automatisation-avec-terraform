
resource "aws_security_group" "WebServerSG" {
  name        = var.SG_NAME
  description = "Manage traffic"

  ingress {
    description      = "Allow HTTP Access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description      = "Allow HTTPS Access"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow SSH Access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "WebServerSG"
  }
}



resource "aws_instance" "WebServer" {
    ami = var.INSTANCE_AMI
    instance_type = var.INSTANCE_TYPE
    user_data = var.WEBSERVER_INSTANCE_USER_DATA
    vpc_security_group_ids = [aws_security_group.WebServerSG.id]
    tags = {
      "Name" = "WebServer"
    }
}